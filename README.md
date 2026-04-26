# 🎸 Cephalophoria Launcher

Script PowerShell pour ouvrir rapidement les fichiers de travail du groupe (tabs, projets DAW, notes, etc.).

> Développé avec l'aide de Claude (Anthropic).

## Principales commandes 

- Ouvrir le dossier du groupe

```powershell
band
```

- Ouvrir le fichier Guitar Pro (.gp) et le projet DAW (.rpp)
```powershell
band <track>
```
*ex : band sn → ouvre Spiritual Necrosis*

- Ouvrir uniquement le fichier Guitar Pro
```powershell
band <track> -gp
```

- Ouvrir uniquement le projet DAW (Reaper)
```powershell
band <track> -daw
```

- Ouvrir tous les fichiers Guitare Pro
```powershell
band all
```

- Ouvrir tous les projets DAW
```powershell
band all -daw
```

- Ouvrir les notes du groupe
```
band notes
```

- Ouvrir un métronome en ligne
```powershell
band metro
```

- Ouvre la liste des commande disponible 
```powershell
band help
```

###  Convention
`<track>` = code court du morceau
*ex: sn → Spiritual Necrosis*

### 📁 Structure attendue

```
Cephalophoria/
├── tabs/
│   ├── sn.gp
│   ├── xx.gp
│
├── daw/
│   ├── sn.rpp
│   ├── xx.rpp
│
├── notes.md
```
sn → Spiritual Necrosis

## 🎸 Installation

> Aucune connaissance en code requise. Suis les étapes dans l'ordre.

---

### 1. Prérequis

- [Guitar Pro](https://www.guitar-pro.com/fr) installé
- [Reaper](https://www.reaper.fm/) installé

---

### 2. Copier les fichiers

Place les fichiers suivants dans un dossier de ton choix.  
*Exemple : `Documents\bandscript\`*

```
bandscript\
├── band_player.ps1
├── .env.example
```

---

### 3. Créer ton fichier de configuration

1. Dans le dossier `bandscript\`, fais un **clic droit** sur `.env.example`
2. Choisis **Copier**, puis **Coller** dans le même dossier
3. Renomme la copie en **`.env`** (supprime le `.example`)
4. Ouvre `.env` avec le **Bloc-notes**
5. Remplace les chemins par les tiens :

```properties
BAND_NAME=cephalophoria
BASE_ROOT=C:\Users\TonPrénom\Desktop\cephalophoria
GP_FOLDER=C:\Users\TonPrénom\Desktop\cephalophoria\tabs
DAW_FOLDER=C:\Users\TonPrénom\Desktop\cephalophoria\daw
NOTES_FILE=C:\Users\TonPrénom\Desktop\cephalophoria\notes.md
METRO_URL=https://www.metronome-en-ligne.com/
```

> 💡 Pour trouver ton prénom dans le chemin : ouvre l'Explorateur de fichiers,  
> clique sur **Ce PC** → **Bureau**. La barre d'adresse affiche le bon chemin.

6. **Sauvegarde** le fichier (`Ctrl+S`)

---

### 4. Structure des dossiers

Ton dossier du groupe doit ressembler à ça :

```
cephalophoria\
├── tabs\
│   ├── sn.gp
│   ├── pmd.gp
│
├── daw\
│   ├── sn.rpp
│   ├── pmd.rpp
│
├── notes.md
```

> 💡 Le nom des fichiers = le code du morceau. Pas d'espaces, tout en minuscules.  
> *ex : `sn` pour Spiritual Necrosis, `pmd` pour Post Mortem Decapitation*

---

### 5. Autoriser PowerShell à lancer des scripts

> Cette étape est nécessaire une seule fois sur ta machine.

1. Clique sur le menu **Démarrer**
2. Tape `powershell` et fais **clic droit** → **Exécuter en tant qu'administrateur**
3. Colle cette commande et appuie sur **Entrée** :

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

4. Tape `O` pour confirmer, puis **Entrée**
5. Ferme cette fenêtre

---

### 6. Ajouter la commande `band`

1. Ouvre **PowerShell** normalement (sans administrateur)
2. Tape cette commande et appuie sur **Entrée** :

```powershell
notepad $PROFILE
```

3. Si le Bloc-notes demande de créer le fichier, clique **Oui**
4. Ajoute ces lignes à la fin du fichier :

```powershell
function band { & "C:\Users\TonPrénom\Documents\bandscript\band_player.ps1" @args }
```

> ⚠️ Remplace `TonPrénom` par ton vrai nom d'utilisateur.

5. **Sauvegarde** (`Ctrl+S`) et ferme le Bloc-notes
6. Dans PowerShell, tape :

```powershell
. $PROFILE
```

---

### 7. Tester

Dans PowerShell, tape :

```powershell
band help
```

Tu dois voir la liste des commandes disponibles. C'est bon ! 🎉

---

### Commandes disponibles

| Commande          | Effet                              |
|-------------------|------------------------------------|
| `band`            | Ouvre le dossier du groupe         |
| `band code_track`         | Ouvre `code_track.gp` + `code_track.rpp`          |
| `band code_track -gp`     | Seulement `code_track.gp`                  |
| `band code_track -daw`    | Seulement `code_track.rpp`                 |
| `band all`        | Tous les `.gp`                     |
| `band all -daw`   | Tous les `.rpp`                    |
| `band notes`      | Ouvre `notes.md`                   |
| `band metro`      | Ouvre le métronome en ligne        |
| `band help`       | Affiche cette aide                 |

---

### En cas de problème

- **"band n'est pas reconnu"** → relis l'étape 6, vérifie le chemin vers `band_player.ps1`
- **"Fichier introuvable"** → vérifie les chemins dans ton `.env` et le nom de tes fichiers `.gp`
- **Le script ne se lance pas** → relis l'étape 5 (autorisation PowerShell)