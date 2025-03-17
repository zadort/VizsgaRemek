import React, { useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import { FaEye, FaEyeSlash } from 'react-icons/fa'; // Ikonok importálása
import './Register.css';

function Register() {
  const { isDarkMode } = useContext(DarkModeContext);

  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false); // Jelszó megjelenítés állapota
  const [showConfirmPassword, setShowConfirmPassword] = useState(false); // Megerősítő jelszó állapota
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (password.length < 6) {
      setErrorMessage('A jelszónak legalább 6 karakter hosszúnak kell lennie!');
      return;
    }

    if (password !== confirmPassword) {
      setErrorMessage('A jelszavak nem egyeznek!');
      return;
    }

    const requestBody = {
      username: username,
      email: email,
      password: password,
    };

    try {
      const response = await fetch('http://localhost:5123/User/registration', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody),
      });

      if (response.ok) {
        setSuccessMessage('Sikeres regisztráció!');
        setErrorMessage('');
        setTimeout(() => {
          navigate('/login');
        }, 1500);
      } else {
        const data = await response.json();
        setErrorMessage(data.message || 'Valami hiba történt!');
      }
    } catch (error) {
      setErrorMessage('A kérés során hiba történt!');
    }
  };

  return (
    <div className={`register-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`register-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Regisztráció</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="username" className="form-label">Felhasználónév</label>
            <input
              type="text"
              className="form-control"
              id="username"
              placeholder="Add meg a felhasználóneved"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
            />
          </div>
          <div className="form-group">
            <label htmlFor="email" className="form-label">Email</label>
            <input
              type="email"
              className="form-control"
              id="email"
              placeholder="Add meg az email címed"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>
          <div className="form-group password-wrapper">
            <label htmlFor="password" className="form-label">Jelszó</label>
            <div className="password-container">
              <input
                type={showPassword ? 'text' : 'password'}
                className="form-control"
                id="password"
                placeholder="Add meg a jelszavad (minimum 6 karakter)"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
              <button
                type="button"
                className="password-toggle"
                onClick={() => setShowPassword(!showPassword)}
              >
                {showPassword ? <FaEyeSlash /> : <FaEye />}
              </button>
            </div>
          </div>
          <div className="form-group password-wrapper">
            <label htmlFor="confirmPassword" className="form-label">Jelszó megerősítése</label>
            <div className="password-container">
              <input
                type={showConfirmPassword ? 'text' : 'password'}
                className="form-control"
                id="confirmPassword"
                placeholder="Erősítsd meg a jelszavad"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
              />
              <button
                type="button"
                className="password-toggle"
                onClick={() => setShowConfirmPassword(!showConfirmPassword)}
              >
                {showConfirmPassword ? <FaEyeSlash /> : <FaEye />}
              </button>
            </div>
          </div>
          <button type="submit" className="btn btn-primary w-100 mt-3">Regisztráció</button>
        </form>

        {errorMessage && (
          <div className="error-message animate-error">
            <p>{errorMessage}</p>
          </div>
        )}
        {successMessage && <p className="success-message">{successMessage}</p>}

        <p className="text-center mt-3">
          Már van fiókod? <a href="/login">Jelentkezz be itt!</a>
        </p>
      </div>
    </div>
  );
}

export default Register;