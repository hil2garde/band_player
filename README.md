# 🎸 Band Player

Script PowerShell pour ouvrir rapidement les fichiers de travail du groupe — tabs Guitar Pro, projets Reaper, notes, métronome.

> Développé avec l'aide de [Claude](https://claude.ai) (Anthropic).

---

## Commandes

| Commande | Effet |
|---|---|
| `band` | Ouvre le dossier du groupe |
| `band <track>` | Ouvre `<track>.gp` + `<track>.rpp` |
| `band <track> -gp` | Seulement le fichier Guitar Pro |
| `band <track> -daw` | Seulement le projet Reaper |
| `band all` | Tous les `.gp` |
| `band all -daw` | Tous les `.rpp` |
| `band notes` | Ouvre `notes.md` |
| `band metro` | Ouvre le métronome en ligne |
| `band help` | Affiche l'aide |

### Convention
`<track>` = code court du morceau, sans espaces, en minuscules.
*ex : `sn` → Spiritual Necrosis, `pmd` → Post Mortem Decapitation*

### Structure attendue

```
cephalophoria/
├── tabs/
│   ├── sn.gp
│   ├── pmd.gp
├── daw/
│   ├── sn.rpp
│   ├── pmd.rpp
└── notes.md
```

---

## Installation

> Aucune connaissance en code requise. Suis les étapes dans l'ordre.

### 1. Prérequis

- [Guitar Pro](https://www.guitar-pro.com/fr)
- [Reaper](https://www.reaper.fm/)

### 2. Copier les fichiers

Place ces fichiers dans un dossier de ton choix, par exemple `Documents\bandscript\` :

```
bandscript/
├── band_player.ps1
├── .env.example
```

### 3. Créer ta configuration

1. Fais un **clic droit** sur `.env.example` → **Copier** → **Coller** dans le même dossier
2. Renomme la copie en **`.env`** (supprime le `.example`)
3. Ouvre `.env` avec le Bloc-notes et remplace les chemins par les tiens :

```properties
BAND_NAME=cephalophoria
BASE_ROOT=C:\Users\TonPrénom\Desktop\cephalophoria
GP_FOLDER=C:\Users\TonPrénom\Desktop\cephalophoria\tabs
DAW_FOLDER=C:\Users\TonPrénom\Desktop\cephalophoria\daw
NOTES_FILE=C:\Users\TonPrénom\Desktop\cephalophoria\notes.md
METRO_URL=https://www.metronome-en-ligne.com/
GP_VERSION=GuitarPro7
```

> 💡 Pour trouver `TonPrénom` : ouvre l'Explorateur → Ce PC → Bureau. Le chemin s'affiche dans la barre d'adresse.

> 💡 Pour trouver ta version de Guitar Pro : ouvre PowerShell et tape :
> ```powershell
> Get-Process | Where-Object { $_.Name -like "*guitar*" }
> ```
> La colonne `ProcessName` affiche le nom exact à copier dans `GP_VERSION`.
> *ex : `GuitarPro7`, `GuitarPro8`...*

4. Sauvegarde (`Ctrl+S`)

### 4. Autoriser PowerShell à lancer des scripts

> Une seule fois sur ta machine.

1. Menu **Démarrer** → tape `powershell` → **clic droit** → **Exécuter en tant qu'administrateur**
2. Colle cette commande :

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. Tape `O` pour confirmer → ferme la fenêtre

### 5. Ajouter la commande `band`

1. Ouvre PowerShell normalement et tape :

```powershell
notepad $PROFILE
```

2. Si le Bloc-notes demande de créer le fichier, clique **Oui**
3. Ajoute cette ligne à la fin (en remplaçant `TonPrénom`) :

```powershell
function band { & "C:\Users\TonPrénom\Documents\bandscript\band_player.ps1" @args }
```

4. Sauvegarde (`Ctrl+S`) et ferme le Bloc-notes
5. Recharge le profile :

```powershell
. $PROFILE
```

### 6. Tester

```powershell
band help
```

Tu dois voir la liste des commandes. C'est bon ! 🎉

---

## En cas de problème

- **"band n'est pas reconnu"** → vérifie le chemin vers `band_player.ps1` dans le profile (étape 5)
- **"Fichier introuvable"** → vérifie les chemins dans ton `.env` et les noms de tes fichiers
- **Le script ne se lance pas** → relis l'étape 4 (autorisation PowerShell)