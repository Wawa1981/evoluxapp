# Limites — EvoluX Mobile (Termux)

## Ce que c’est

- Un **environnement Linux en proot** dans Termux (Android).  
- Outils **finance / sécu / CLI** sous branding EvoluX.  
- Même *esprit* que « Kali dans Termux », pas le même produit que l’ISO PC.

## Ce que ce n’est pas

| Mythe | Réalité |
|-------|---------|
| « Je boote l’ISO EvoluX sur le téléphone » | Non — l’ISO est **x86_64** pour PC |
| « C’est un vrai dual-boot Android » | Non — **proot**, pas de kernel Linux séparé |
| « XFCE full comme sur l’ISO » | Pas en v1 (trop lourd) |
| « DistroWatch liste evoluxapp » | DistroWatch cible l’**ISO PC** (`evolux`) |
| « Root Android obligatoire » | **Non** — proot sans root |

## Performances

- Plus lent qu’un PC.  
- Les apps graphiques lourdes (GnuCash GUI, LibreOffice) ne sont **pas** le focus mobile.  
- Préférer les outils **CLI** listés dans `bootstrap/packages.txt`.

## Sécurité

- Utile pour apprendre et travailler en mobilité.  
- **Ne pas** stocker des seed phrases / mots de passe critiques uniquement dans proot sans sauvegarde chiffrée externe.  
- `pass` + GPG : configure une phrase de passe solide.

## Architecture

- Support officiel v1 : **aarch64** (ARM 64).  
- Téléphones 32-bit : non prioritaires.
