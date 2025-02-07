import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import Nav from './components/Nav';
import Home from './components/Home';
import Cart from './components/Cart';
import Footer from './components/Footer';
import Login from './components/Login';
import Register from './components/Register';
import ForgotPassword from './components/ForgotPassword';
import ASZF from './components/ASZF';
import Kapcsolat from './components/Kapcsolat';
import Adatkezeles from './components/Adatkezeles';
import CookieBanner from './components/CookieBanner';
import { DarkModeProvider } from './components/DarkModeContext';
import './App.css';

function App() {
  const [cart, setCart] = useState([]);

  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem('cart')) || [];
    setCart(savedCart);
  }, []);

  const updateCart = (newCart) => {
    setCart(newCart);
    localStorage.setItem('cart', JSON.stringify(newCart));
  };

  return (
    <DarkModeProvider>
      <Router>
        <CookieBanner />
        <div className="App">
          <Header cart={cart} />
          <Nav />
          <Routes>
            <Route path="/" element={<Home cart={cart} updateCart={updateCart} />} />
            <Route path="/cart" element={<Cart cart={cart} updateCart={updateCart} />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            <Route path="/aszf" element={<ASZF />} />
            <Route path="/kapcsolat" element={<Kapcsolat />} />
            <Route path="/adatkezeles" element={<Adatkezeles />} />
          </Routes>
          <Footer />
        </div>
      </Router>
    </DarkModeProvider>
  );
}

export default App;