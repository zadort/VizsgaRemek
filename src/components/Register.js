import React, { useState, useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Register.css';

function Register() {
  const { isDarkMode } = useContext(DarkModeContext);

  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (password !== confirmPassword) {
      setErrorMessage('A jelszavak nem egyeznek!');
      return;
    }

    const requestBody = {
      Felhasznalonev: username,
      Email: email,
      Jelszo: password,
    };

    try {
      const response = await fetch('https://localhost:7051/Felhasznalo/register', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody),
      });

      if (response.ok) {
        setSuccessMessage('Sikeres regisztráció!');
        setErrorMessage('');
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
          <div className="form-group">
            <label htmlFor="password" className="form-label">Jelszó</label>
            <input
              type="password"
              className="form-control"
              id="password"
              placeholder="Add meg a jelszavad"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>
          <div className="form-group">
            <label htmlFor="confirmPassword" className="form-label">Jelszó megerősítése</label>
            <input
              type="password"
              className="form-control"
              id="confirmPassword"
              placeholder="Erősítsd meg a jelszavad"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
            />
          </div>
          <button type="submit" className="btn btn-primary w-100 mt-3">Regisztráció</button>
        </form>

        {errorMessage && <p className="text-danger text-center mt-3">{errorMessage}</p>}
        {successMessage && <p className="text-success text-center mt-3">{successMessage}</p>}

        <p className="text-center mt-3">
          Már van fiókod? <a href="/login">Jelentkezz be itt!</a>
        </p>
      </div>
    </div>
  );
}

export default Register;
