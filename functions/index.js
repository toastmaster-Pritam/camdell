// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

// Initialize Firebase Admin
admin.initializeApp();

const app = express();
app.use(cors({ origin: true }));

// Initialize Firestore
const db = admin.firestore();

// Email configuration
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER, // Set this in Firebase environment
    pass: process.env.EMAIL_PASS  // Set this in Firebase environment
  }
});

// Generate OTP
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

// Store OTP in Firestore with expiration
async function storeOTP(email, otp) {
  const otpRef = db.collection('otps').doc(email);
  const expirationTime = new Date();
  expirationTime.setMinutes(expirationTime.getMinutes() + 10); // OTP valid for 10 minutes

  await otpRef.set({
    otp: otp,
    email: email,
    expiresAt: admin.firestore.Timestamp.fromDate(expirationTime),
    attempts: 0
  });
}

// Verify if OTP exists and is valid
async function verifyOTP(email, userOtp) {
  const otpRef = db.collection('otps').doc(email);
  const otpDoc = await otpRef.get();

  if (!otpDoc.exists) {
    return { isValid: false, message: 'OTP not found' };
  }

  const otpData = otpDoc.data();
  const now = admin.firestore.Timestamp.now();

  // Check if OTP is expired
  if (now.toMillis() > otpData.expiresAt.toMillis()) {
    await otpRef.delete();
    return { isValid: false, message: 'OTP expired' };
  }

  // Check if too many attempts
  if (otpData.attempts >= 3) {
    await otpRef.delete();
    return { isValid: false, message: 'Too many attempts' };
  }

  // Update attempts
  await otpRef.update({
    attempts: admin.firestore.FieldValue.increment(1)
  });

  // Check if OTP matches
  if (otpData.otp !== userOtp) {
    return { isValid: false, message: 'Invalid OTP' };
  }

  // OTP is valid - clean up
  await otpRef.delete();
  return { isValid: true, message: 'OTP verified' };
}

// Send OTP Email
async function sendOTPEmail(email, otp) {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: 'Your Login OTP',
    html: `
      <h1>Login Verification Code</h1>
      <p>Your OTP for login is: <strong>${otp}</strong></p>
      <p>This code will expire in 10 minutes.</p>
      <p>If you didn't request this code, please ignore this email.</p>
    `
  };

  await transporter.sendMail(mailOptions);
}

// Endpoint to request OTP
app.post('/requestOTP', async (req, res) => {
  try {
    const { email } = req.body;
    
    if (!email) {
      return res.status(400).json({ success: false, message: 'Email is required' });
    }

    // Generate and store OTP
    const otp = generateOTP();
    await storeOTP(email, otp);
    
    // Send OTP via email
    await sendOTPEmail(email, otp);

    res.status(200).json({ 
      success: true, 
      message: 'OTP sent successfully' 
    });
  } catch (error) {
    console.error('Error sending OTP:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to send OTP', 
      error: error.message 
    });
  }
});

// Endpoint to verify OTP and create/login user
app.post('/verifyOTP', async (req, res) => {
  try {
    const { email, otp } = req.body;

    if (!email || !otp) {
      return res.status(400).json({ 
        success: false, 
        message: 'Email and OTP are required' 
      });
    }

    // Verify OTP
    const verificationResult = await verifyOTP(email, otp);
    if (!verificationResult.isValid) {
      return res.status(400).json({ 
        success: false, 
        message: verificationResult.message 
      });
    }

    // Check if user exists
    let userRecord;
    try {
      userRecord = await admin.auth().getUserByEmail(email);
    } catch (error) {
      // If user doesn't exist, create new user
      if (error.code === 'auth/user-not-found') {
        const randomPassword = crypto.randomBytes(16).toString('hex');
        userRecord = await admin.auth().createUser({
          email: email,
          password: randomPassword,
          emailVerified: true
        });

        // Create user profile in Firestore
        await db.collection('users').doc(userRecord.uid).set({
          email: email,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          lastLogin: admin.firestore.FieldValue.serverTimestamp()
        });
      } else {
        throw error;
      }
    }

    // Create custom token
    const customToken = await admin.auth().createCustomToken(userRecord.uid);

    // Update last login
    await db.collection('users').doc(userRecord.uid).update({
      lastLogin: admin.firestore.FieldValue.serverTimestamp()
    });

    res.status(200).json({
      success: true,
      message: 'OTP verified successfully',
      token: customToken
    });
  } catch (error) {
    console.error('Error verifying OTP:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to verify OTP', 
      error: error.message 
    });
  }
});

// Export the Express app as a Firebase Cloud Function
exports.emailAuth = functions.https.onRequest(app);