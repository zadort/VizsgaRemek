import React, { useState, useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import { useAuth } from './AuthContext';
import { jwtDecode } from 'jwt-decode'; // Helyes importálás
import './Login.css';

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const { isDarkMode } = useContext(DarkModeContext);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch('http://localhost:5123/User/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
      });

      const data = await response.json();

      if (response.ok) {
        // Mentjük a JWT tokent a localStorage-ba
        localStorage.setItem('token', data.token);

        // Dekódoljuk a tokent, hogy kinyerjük a felhasználói ID-t
        const decodedToken = jwtDecode(data.token);
        const userId = decodedToken.sub; // A "sub" mező tartalmazza a felhasználó ID-jét
        console.log('Bejelentkezett felhasználó ID:', userId);

        // Bejelentkezés állapot frissítése
        login();
        setSuccessMessage('Sikeres bejelentkezés!');
        setError('');

        // Átirányítás a kezdőlapra
        setTimeout(() => {
          navigate('/');
        }, 1500);
      } else {
        setError(data.message || 'Hibás felhasználónév vagy jelszó');
        setSuccessMessage('');
      }
    } catch (error) {
      console.error('Hiba történt a bejelentkezés során:', error);
      setError('Hiba történt a bejelentkezés során');
      setSuccessMessage('');
    }
  };

  return (
    <div className={`login-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`login-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Bejelentkezés</h2>
        {error && <div className="error-message">{error}</div>}
        {successMessage && <div className="success-message">{successMessage}</div>}
        <form onSubmit={handleLogin}>
          <div className="form-group">
            <label htmlFor="username" className="form-label">Felhasználónév</label>
            <input
              type="text"
              className="form-control"
              id="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="Add meg a felhasználóneved"
              required
            />
          </div>
          <div className="form-group password-wrapper">
            <label htmlFor="password" className="form-label">Jelszó</label>
            <div className="password-container">
              <input
                type={showPassword ? 'text' : 'password'}
                className="form-control"
                id="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Add meg a jelszavad"
                required
              />
              <button
                type="button"
                className="password-toggle"
                onClick={() => setShowPassword(!showPassword)}
              >
                {showPassword ? '🙈' : '👁️'}
              </button>
            </div>
          </div>
          <button type="submit" className="btn btn-primary w-100 mt-3">
            Bejelentkezés
          </button>
        </form>
        <p className="text-center mt-3">
          Nincs még fiókod? <Link to="/register">Regisztrálj itt!</Link>
        </p>
        <p className="text-center mt-2">
          <Link to="/forgot-password">Elfelejtetted a jelszavad?</Link>
        </p>
      </div>
    </div>
  );
}

export default Login;