import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './Login.css';

function Login() {
  const { isDarkMode } = useContext(DarkModeContext);

  return (
    <div className={`login-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`login-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Bejelentkezés</h2>
        <form>
          <div className="form-group">
            <label htmlFor="username" className="form-label">Felhasználónév</label>
            <input
              type="text"
              className="form-control"
              id="username"
              placeholder="Add meg a felhasználóneved"
            />
          </div>
          <div className="form-group">
            <label htmlFor="password" className="form-label">Jelszó</label>
            <input
              type="password"
              className="form-control"
              id="password"
              placeholder="Add meg a jelszavad"
            />
          </div>
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