import React, { useContext, useState } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Kapcsolat.css';

const Kapcsolat = () => {
  const { isDarkMode } = useContext(DarkModeContext);

  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
  });

  const [responseMessage, setResponseMessage] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('http://localhost:5123/User/send-message', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          Name: formData.name,
          Email: formData.email,
          Content: formData.message,
        }),
      });

      if (response.ok) {
        const data = await response.json();
        setResponseMessage(data.message);
        setFormData({ name: '', email: '', message: '' });
      } else {
        setResponseMessage('Hiba történt az üzenet küldésekor.');
      }
    } catch (error) {
      console.error('Hiba:', error);
      setResponseMessage('Nem sikerült csatlakozni a szerverhez.');
    }
  };

  return (
    <div className={`kapcsolat-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <h1>Kapcsolat</h1>
      <p>Kérdése van vagy segítségre van szüksége? Lépjen kapcsolatba velünk!</p>

      <div className="kapcsolat-info">
        <h2>Elérhetőségek</h2>
        <p><strong>Cím:</strong> 1234 Budapest, Vásárló utca 1.</p>
        <p><strong>Telefon:</strong> +36 1 234 5678</p>
        <p><strong>E-mail:</strong> technestthereal@gmail.com</p>
        <p><strong>Nyitvatartás:</strong> Hétfőtől péntekig, 9:00 - 17:00</p>
      </div>

      <div className="kapcsolat-urmap">
        <h2>Írjon nekünk!</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="name">Név:</label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="email">E-mail:</label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="message">Üzenet:</label>
            <textarea
              id="message"
              name="message"
              rows="5"
              value={formData.message}
              onChange={handleChange}
              required
            ></textarea>
          </div>
          <button type="submit">Üzenet küldése</button>
        </form>
        {responseMessage && <p className="response-message">{responseMessage}</p>}
      </div>
    </div>
  );
};

export default Kapcsolat;