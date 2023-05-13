# Connexion
* `ssh nomUtilisateur@nomCalculateur.computecanada.ca`
* Espace de travail personnel => `~/projects/def-nomDirecteur/nomUtilisateur/`

# Préparation du code
* `git clone \[repo\]`
* `sftp` ou Globus pour envoyer les données (ou du code aussi, si vous n'utilisez pas `git`)
* `module avail python` (lister les versions Python disponible)
* `module load python/version` (e.g. python/3.8)
* `virtualenv ENV`
* `source ENV/bin/activate`
* `pip install --no-index requirements.txt`
* Demander une allocation interactive avec salloc (exemple de commande dans le fichier `salloc.txt` de ce repo) et tester le script sur le noeud de calcul alloué

# Lancement des expés
* Faire un script bash avec les commandes `SBATCH` à l'intérieur (e.g. le script `batch_script.sh` dans ce repo)
* `sbatch batch_script.sh`
* Si vous demandez beaucoup de ressources, assurez-vous de les utiliser! Par exemple, demander 10 CPUs mais ne pas faire `export OMP_NUM_THREADS=n_cpus` dans le script batch fait en sorte que `numpy` n'utilisera qu'un seul CPU pour calculer!
* Demander beaucoup de ressources mais ne pas les utiliser influence négativement vos priorités futures car Slurm compte l'utilisation que vous faite des ressources pour vous faire une allocation.

# Paramètres Slurm importants
* `account=def-nomDirecteur`: nécessaire, dit à Slurm dans quel "projet" rouler la job. Si ce n'est pas présent, vous allez attendre très longtemps avant d'avoir une allocation.
* `ntasks`: nombre de tâches (e.g. nombre de thread OMP ou de processus MPI), défaut = 1. Utile si on veut faire du calcul distribué ou parallélisé à même notre script.
* `cpus-per-tasks`: nécessaire, nombre de cpu par tâches. Si `ntasks=1` alors c'est le nombre de coeurs demandés.
* `mem`: nécessaire, quantité de mémoire vive. Ne pas oublier de mettre le `M` pour Megabytes ou `G` pour Gigabytes.
* `time`: nécessaire, durées maximale de l'expérience / job. Toujours mettre la quantité maximale pour la file dans laquelle vous vous trouvez (e.g. une expé de 6 heures devrait demander 12h).
* `gres=gpu:N`: nombre de GPU, où `N` est le nombre. Si ce n'est pas explicitement demandé, aucun GPU n'est alloué.
* `mail-user=tonCourriel@domaine.com`: dit à Slurm de t'envoyer une notification par courriel si la job termine (succès, arrêt imprévu, plantage, etc.).

# Surveiller des expés
* `sq`
* `seff -j #` où `#` est le numéro de job donné a l'expérience par Slurm

# Systèmes de fichiers / Où mettre les résultats
* Beaucoup d'écriture (e.g. plein de fichiers intermédiaires ou écriture constante dans un fichier) => `/scratch`
* Peu d'écriture (e.g. sauvegarde d'un seul modèle et de quelques métriques de performances à la fin d'une expérience) => `/projects` est correct
* `nearline` sert à stocker des données inactives que vous voulez conserver. Si vous voulez l'utiliser, compressez vos données avant de les envoyer sur `nearline`.

# Rapatrier les résultats
* `sftp` si peu de volume (e.g. quelques Megabytes)
* Globus si gros volume (e.g. plusieurs Gigabytes)
* `sftp` marchera pour des gros volumes aussi, mais c'est votre temps qui en écope.
