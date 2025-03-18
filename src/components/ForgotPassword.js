import React, { useState, useContext } from 'react';
import { Link } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './ForgotPassword.css';

function ForgotPassword() {
  const { isDarkMode } = useContext(DarkModeContext);
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch('http://localhost:5123/User/reset-password', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email }),
      });

      const data = await response.json();

      if (response.ok) {
        setMessage(data.message || 'A jelszó visszaállítás sikeres! Ellenőrizd az email fiókodat.');
        setError('');
      } else {
        setError(data.message || 'Hiba történt a jelszó visszaállítása során.');
        setMessage('');
      }
    } catch (error) {
      setError('Hiba történt a jelszó visszaállítása során.');
      setMessage('');
    }
  };

  return (
    <div className={`forgot-password-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`forgot-password-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Elfelejtett jelszó</h2>
        {message && <div className="success-message">{message}</div>}
        {error && <div className="error-message">{error}</div>}
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="email" className="form-label">Email cím</label>
            <input
              type="email"
              className="form-control"
              id="email"
              placeholder="Add meg az email címed"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <button type="submit" className="btn btn-primary w-100 mt-3">Küldés</button>
        </form>
        <p className="text-center mt-3">
          <Link to="/login">Vissza a bejelentkezéshez</Link>
        </p>
      </div>
    </div>
  );
}

export default ForgotPassword;