import React, { useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Adatkezeles.css';

const Adatkezeles = () => {
  const { isDarkMode } = useContext(DarkModeContext);

  return (
    <div className={`adatkezeles-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <h1>Adatvédelmi Szabályzat</h1>
      <p>Köszönjük, hogy webáruházunkat választotta! Az alábbiakban tájékoztatjuk, hogyan kezeljük felhasználóink adatait.</p>

      <h2>1. Az adatkezelés alapvetése</h2>
      <p>1.1. A webáruház tulajdonosa: Elektronikai Shop, székhely: 1234 Budapest, Vásárló utca 1.</p>
      <p>1.2. Az adatkezelés célja: A rendelések feldolgozása, a vásárlói élmény javítása, és a jogi kötelezettségek teljesítése.</p>

      <h2>2. Kezelt adatok</h2>
      <p>2.1. Személyes adatok: név, e-mail cím, telefonszám, szállítási cím.</p>
      <p>2.2. Technikai adatok: IP cím, böngésző típusa, operációs rendszer.</p>

      <h2>3. Adatkezelési jogalap</h2>
      <p>3.1. Az adatkezelés jogalapja a felhasználó hozzájárulása, valamint a szerződés teljesítése.</p>
      <p>3.2. A felhasználó bármikor visszavonhatja hozzájárulását.</p>

      <h2>4. Adattovábbítás</h2>
      <p>4.1. Az adatokat harmadik félnek csak a szállítás és fizetés céljából továbbítjuk.</p>
      <p>4.2. Az adatokat nem adjuk át harmadik országokba.</p>

      <h2>5. Adatvédelmi jogok</h2>
      <p>5.1. A felhasználóknak joguk van hozzáférni, helyesbíteni, törölni vagy korlátozni adataikat.</p>
      <p>5.2. Az adatvédelmi kérelmeket az info@elektronikaishop.hu címen lehet benyújtani.</p>

      <h2>6. Cookie-k használata</h2>
      <p>6.1. A webáruház cookie-kat használ a felhasználói élmény javítása érdekében.</p>
      <p>6.2. A cookie-kat a böngésző beállításaiban lehet letiltani.</p>

      <h2>7. Egyéb rendelkezések</h2>
      <p>7.1. Az adatvédelmi szabályzat bármikor módosítható.</p>
      <p>7.2. Az adatkezelési gyakorlatokról a [weboldal link] címen tájékozódhat.</p>

      <p>Utolsó frissítés: 2025. 02. 05.</p>
    </div>
  );
};

export default Adatkezeles;