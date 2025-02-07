import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './ForgotPassword.css';

function ForgotPassword() {
  const { isDarkMode } = useContext(DarkModeContext);

  return (
    <div className={`forgot-password-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className={`forgot-password-box ${isDarkMode ? 'dark-mode' : ''}`}>
        <h2 className="text-center mb-4">Elfelejtett jelszó</h2>
        <form>
          <div className="form-group">
            <label htmlFor="email" className="form-label">Email cím</label>
            <input
              type="email"
              className="form-control"
              id="email"
              placeholder="Add meg az email címed"
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