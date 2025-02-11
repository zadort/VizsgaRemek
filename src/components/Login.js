import React, { useState, useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './Login.css';

function Login() {
  const { isDarkMode } = useContext(DarkModeContext);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate(); // Navigációhoz szükséges

  const handleLogin = async (e) => {
    e.preventDefault();

    // A backend API URL-t pontosan állítsd be
    const response = await fetch('https://localhost:7051/api/Felhasznalo/login', { // Backend HTTPS URL
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });
    //debug


    if (response.ok) {
      const data = await response.json();
      // A válaszban kapott token elmentése localStorage-ba
      localStorage.setItem('jwt', data.token);
      navigate('/dashboard'); // Ha sikeres, irányítsuk át a felhasználót
    } else {
      // Ha hibás a bejelentkezés, állítsuk be a hibaüzenetet
      const errorData = await response.json();
      setError(errorData.message || 'Hiba történt a bejelentkezéskor');
    }
  };

  return (
    <div className={`login-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`login-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Bejelentkezés</h2>
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
            />
          </div>
          {error && <div className="alert alert-danger mt-2">{error}</div>} {/* Hibaüzenet megjelenítése */}
          <button type="submit" className="btn btn-primary w-100 mt-3">Bejelentkezés</button>
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
