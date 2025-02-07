import React from 'react';
import { Link } from 'react-router-dom';

function Nav() {
  return (
    <nav>
      <Link to="/">Kezdőlap</Link>
      <Link to="#categories">Kategóriák</Link>
      <Link to="#products">Termékek</Link>
      <Link to="/kapcsolat">Kapcsolat</Link>
    </nav>
  );
}

export default Nav;