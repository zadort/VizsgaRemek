import React, { useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Register.css';

function Register() {
  const { isDarkMode } = useContext(DarkModeContext);

  return (
    <div className={`register-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`register-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Regisztráció</h2>
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
            <label htmlFor="email" className="form-label">Email</label>
            <input
              type="email"
              className="form-control"
              id="email"
              placeholder="Add meg az email címed"
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
          <div className="form-group">
            <label htmlFor="confirmPassword" className="form-label">Jelszó megerősítése</label>
            <input
              type="password"
              className="form-control"
              id="confirmPassword"
              placeholder="Erősítsd meg a jelszavad"
            />
          </div>
          <button type="submit" className="btn btn-primary w-100 mt-3">Regisztráció</button>
        </form>
        <p className="text-center mt-3">
          Már van fiókod? <a href="/login">Jelentkezz be itt!</a>
        </p>
      </div>
    </div>
  );
}

export default Register;