# Installer EvoluX Mobile dans Termux

Guide **sans blabla** — comme installer une distro (Kali, Debian…) dans Termux, version **EvoluX finance**.

## 1. Préparer Termux

1. Installe **Termux** (de préférence **F-Droid**).  
2. Ouvre Termux et autorise le stockage si demandé.  
3. Mets à jour les paquets Termux :

```bash
pkg update && pkg upgrade -y
```

## 2. Cloner ce dépôt

```bash
pkg install git -y
git clone https://github.com/Wawa1981/evoluxapp.git
cd evoluxapp
```

## 3. Lancer l’installeur

```bash
bash scripts/install-in-termux.sh
```

L’installeur va :

1. Installer `proot-distro`  
2. Installer une base **Debian** (aarch64)  
3. L’enregistrer sous l’alias **`evolux`** (si supporté) ou te dire comment te connecter  
4. Appliquer le branding EvoluX + paquets finance (`bootstrap/`)

Durée : souvent **10–30 minutes** selon le réseau.

## 4. Entrer dans EvoluX

```bash
proot-distro login evolux
```

Si l’alias n’existe pas (ancienne proot-distro) :

```bash
proot-distro login debian
# puis à l’intérieur, le branding EvoluX est déjà appliqué
```

Ou :

```bash
bash scripts/login.sh
```

## 5. Premiers outils

Une fois **dans** la distro :

```bash
evolux-welcome          # rappel des commandes
ledger --version        # compta CLI
qalc 100*1.2            # calculatrice
gpg --version
python3 --version
```

Mise à jour des paquets (dans EvoluX) :

```bash
apt update && apt upgrade -y
```

## 6. Quitter

```bash
exit
```

Tu reviens dans Termux (Android).

## Désinstaller

```bash
proot-distro remove evolux
# ou: proot-distro remove debian
```

## Problèmes fréquents

| Problème | Piste |
|----------|--------|
| Pas assez d’espace | Libérer 2–4 Go ; vider le cache Termux |
| `proot-distro: command not found` | `pkg install proot-distro` |
| Architecture | Téléphone **aarch64** requis |
| Electrum absent | Voir `packages.txt` — optionnel / pas toujours dans les dépôts ARM |
| Tu voulais l’ISO PC | Ce n’est **pas** ce repo → [Wawa1981/evolux](https://github.com/Wawa1981/evolux) |

## Suite

- Lire [docs/LIMITS.md](docs/LIMITS.md)  
- Distro PC / DistroWatch → repo **evolux**, pas evoluxapp  
