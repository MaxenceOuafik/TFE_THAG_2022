# L'initiation et le suivi du traitement hormonal d'affirmation de genre en médecine générale : résultats d'une étude de cohorte et recommandations pour la pratique clinique

## Résumé du projet

**Introduction :** l'accès au soin des personnes transgenres est mauvais, en raison notamment d'un manque de formation des soignant·e·s. Ces difficultés exacerbent les disparités de santé qui les touchent et les empêchent de bénéficier de soins de qualité, qu'ils soient généraux ou trans-spécifiques. Le traitement hormonal d'affirmation de genre (THAG) fait partie de ces soins trans-spécifiques et permet d'améliorer le bien-être des personnes qui en ont besoin. Malheureusement, peu de médecins entreprennent ce genre de traitements. L'objectif de ce TFE est donc de présenter un retour d'expérience ainsi que des recommandations dans l'espoir que davantage de généralistes se sentent en mesure de suivre des patient·e·s transgenres et contribuent ainsi à les lier au soin.

**Méthodologie :** j'ai mené une étude rétrospective avec une analyse mixte par conversion à partir des dossiers médicaux des patient·e·s pour lesquel·le·s j'ai initié un THAG dans ma pratique clinique. Les informations démographiques et les valeurs de laboratoire aux différentes consultations ont été extraites des dossiers informatiques afin d'être synthétisées et analysées. Les informations relatives au coming out, au soutien social, aux démarches de préservation de la fertilité et aux besoins en termes de soins d'affirmation de genre ont été codées en variables quantitatives à partir des notes de consultation pour être examinées.

**Résultats :** les données de 26 patient·e·s suivi·e·s pendant une durée médiane de 6 mois depuis l'instauration du THAG ont été étudiées. Il s'agit d'un échantillon composé d'une population jeune, dotée d'une grande mobilité géographique, aux besoins variés en termes de soins trans-affirmatifs et bénéficiant d'un bon soutien social en général. En outre, l'application des guidelines sur le THAG dans un contexte de médecine générale a permis d'obtenir des résultats satisfaisants au niveau des valeurs de laboratoire.

**Conclusion :** ce TFE contribue à montrer que l'instauration d'un THAG peut faire partie des compétences des médecins généralistes et que proposer des soins trans-spécifiques en première ligne comporte des avantages pour les patient·e·s, par rapport aux centres hospitaliers. Il souligne également l'importance d'offrir des soins de qualité dans un cadre trans-affirmatif pour contribuer à améliorer le bien-être des personnes transgenres.

## Organisation du répertoire

-   **docs** : ce dossier contient les fichiers générés par bookdown en vue de créer la version HTML du TFE.

-   **files** : les différentes images utilisées pour la version HTML du TFE, la page de couverture du TFE, la bibliographie non traitée, et les schémas générés en dehors de RStudio se trouvent tous dans ce dossier.

-   **output** : ce dossier contient tous les graphiques générés via R dans un sous-dossier intitulé *plots* ainsi que la version Word du TFE

-   **renv** contient une copie de tous les packages utilisés pour l'élaboration de ce projet dans la version utilisée lors du TFE

-   **scripts** contient les différents scripts ayant permis la manipulation des données (sous-dossier *data_manipulation*), la création des graphiques (sous-dossier *plots*), ainsi que la création des tables (sous-dossier *tables*). Il contient également deux scripts importants : *import_data.R* qui permet d'importer les données, ainsi que *render_book.R* qui permet de créer le fichier Word et le site HTML à partir des fichiers RMarkdown et des scripts.

Au sein du dossier principal, on retrouve quelques fichiers importants :

-   Les fichiers YAML ayant permis la configuration du projet

-   Le fichier *renv.lock* qui contient les informations sur les packages et version de R utilisées pour ce projet

-   Le template Word du TFE, qui permet de donner le style au fichier Word final (*TFE_template.docx)*

-   La feuille de style ayant permis de modifier l'esthétique du site du TFE *(style.css)*

-   La feuille de style des références bibliographiques, au format Vancouver *(vancouver.csl)*

-   Les références bibliographiques citées dans ce travail au format BibTex (*references.bib).* À la différence du fichier *TFE.bib* qui se trouve dans ./files/ ce fichier ne comporte que les références ayant réellement été citées dans ce TFE.

-   le fichier *TFE_THAG_2022.Rproj* qui contient les configurations du projet

-   Le fichier *.Rprofile* qui permet d'initier la bibliothèque de packages du projet à l'ouverture du projet

-   Les différents fichiers RMarkdown correspondant aux différentes parties du TFE.

## Pour reproduire ce travail

Pour recréer le TFE, il suffit, en théorie, de télécharger ce répertoire et d'utiliser la fonction *renv::restore()* pour réinstaller tous les packages nécessaires. Par la suite, exécuter le script *render_book.R* permet de reproduire la totalité du travail.

Toutefois, pour des raisons de confidentialité, les données personnelles des patient·e·s n'ont pas été partagées dans ce répertoire. Autrement dit, il n'est pas possible de reproduire le travail. L'intérêt de ce répertoire est une démonstration du travail de codage derrière le TFE. Par ailleurs, dans un souci de transparence, les différents scripts peuvent être analysés afin de montrer comment les différentes données ont été traitées et quels calculs ont été réalisés.

## Contributions

La totalité de ce travail a été réalisé par mes soins.

Je remercie Zélie Huvelle de Genres Pluriels ainsi que mes ami·e·s pour leur travail de relecture sur le texte final.

## Licence

Tous les fichiers de ce répertoire sont sous la licence Creative Commons CC BY-NC 4.0. Quiconque peut partager et adapter les différents fichiers tant que l'œuvre originale est créditée et qu'aucune utilisation commerciale n'est faite de ce travail ou de tout ou partie du matériel le composant.

Plus d'informations sur la licence peuvent être trouvées [ici](https://creativecommons.org/licenses/by-nc/4.0/deed.fr).
