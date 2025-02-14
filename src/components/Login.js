import React, { useState, useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import { useAuth } from './AuthContext';
import './Login.css';

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const { isDarkMode } = useContext(DarkModeContext);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch('https://localhost:7051/Felhasznalo/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ felhasznalonev: username, jelszo: password }),
      });

      const data = await response.json();

      if (response.ok) {
        login();
        navigate('/');
      } else {
        setError(data.message || 'Hibás felhasználónév vagy jelszó');
      }
    } catch (error) {
      setError('Hiba történt a bejelentkezés során');
    }
  };

  return (
    <div className={`login-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`login-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Bejelentkezés</h2>
        {error && <p className="error-message">{error}</p>}
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
          <div className="form-group">
            <label htmlFor="password" className="form-label">Jelszó</label>
            <input
              type="password"
              className="form-control"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Add meg a jelszavad"
              required
            />
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