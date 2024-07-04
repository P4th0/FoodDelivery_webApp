# FoodDelivery Project

Aplicație dezvoltată în cadrul materiei de Pratică la Facultatea de Matematică - Infomratică din cadrul Universității Ovidius

## Cerințe pentru rulare
- C# ASP.NET Core 6
- Microsoft SQL Server 2022
- NodeJS v.20.13.0

## Rulare proiect
1. Se importează baza de date conform fișierului SQL încărcat în rădăcina acestui repository.
2. Pentru ASP.NET Core este necesară importarea certificatului SSL generat la build.
3. Pentru front-end în cadrul fiecărui serviciu aflat în `/frontend/services` este necesară setarea portului pentru fiecare apel API la backend
4. Rulați în tandem backend și frontend. Accesați cu IP-ul oferit de Node.JS în consolă

## Funcționalitate implementată
- Sistem de autentificare pe bază de session ID la nivel de front-end (stocate în tabela `user_Session` în baza de date) și cookies la nivel de backend securizate. Session ID-ul fiecărui utilizator este reținut în baza de date și are o expirare de o oră de la momentul conectării. La fiecare repornire de backend, tabela de session ID-uri este curățată la nivel de bază de date.
- Funcționalitate de plasare a comenzilor de la diferite restaurante. Coșul este stocat prin local storage prin baza unui dicționar unde cheia este reprezentată de ID-ul produsului și valoarea fiind cantitatea comandată. 
- Se realizează validări la nivel de backend asupra fiecărei operațiuni la nivel de front-end pentru a preveni injectări SQL sau XSS.
- Utilizatorul poate vizualiza profilul și comenzile realizate. Produsele comandate sunt afișate sub forma unui dialog

## Pentru pachetele NODE.JS 

Dacă NODE.JS nu găsește modulele folosite pentru dezvoltare, se va rula următoarea comandă:
```ps
npm install -g
```