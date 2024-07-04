const isAuthenticated = (req, res, next) => {
    const sessionId = req.cookies.sessionId;
    // Verifică dacă există sessionId și dacă este valid
    if (sessionId) {
      // Utilizatorul este autentificat, permite accesul
      next();
    } else {
      res.status(403).json({ message: 'No access! Please login first!' });
      res.redirect('/'); // sau res.status(401).send('Unauthorized');
    }
  };
  
  module.exports = isAuthenticated;