
-- Suppression du schéma BD_MAGASINS et son contenu s'il existe.
DROP SCHEMA IF EXISTS BD_MAGASINS CASCADE;
-- Création du schéma BD_MAGASINS.
CREATE SCHEMA BD_MAGASINS;
SET search_path TO BD_MAGASINS;

CREATE TABLE MAGASIN(
   num_mag INT,
   nom_rue_mag VARCHAR(50),
   code_p_mag VARCHAR(50),
   ville_mag VARCHAR(50),
   pays_mag VARCHAR(50),
   sup_stock_mag VARCHAR(50),
   num_rue_mag VARCHAR(50),
   PRIMARY KEY(num_mag)
);

CREATE TABLE CLIENT(
   num_cl INT,
   nom_cl VARCHAR(50),
   prenom_cl VARCHAR(50),
   email_cl VARCHAR(50),
   PRIMARY KEY(num_cl)
);

CREATE TABLE EMPLOYE(
   num_emp INT,
   nom_emp VARCHAR(50),
   prenom_emp VARCHAR(50),
   ddn_emp DATE,
   num_mag INT NOT NULL,
   PRIMARY KEY(num_emp),
   FOREIGN KEY(num_mag) REFERENCES MAGASIN(num_mag)
);

CREATE TABLE FOURNISSEUR(
   num_fourn INT,
   nom_fourn VARCHAR(50),
   num_rue_fourn VARCHAR(50),
   nom_rue_fourn VARCHAR(50),
   code_p_fourn VARCHAR(50),
   ville_fourn VARCHAR(50),
   pays_fourn VARCHAR(50),
   PRIMARY KEY(num_fourn)
);

CREATE TABLE CARTE_FIDELITE(
   num_carte_f INT,
   date_creation_carte_f DATE,
   num_cl INT NOT NULL,
   num_mag INT NOT NULL,
   PRIMARY KEY(num_carte_f),
   UNIQUE(num_cl),
   FOREIGN KEY(num_cl) REFERENCES CLIENT(num_cl),
   FOREIGN KEY(num_mag) REFERENCES MAGASIN(num_mag)
);

CREATE TABLE ACHAT(
   num_achat INT,
   date_achat DATE,
   num_cl INT NOT NULL,
   num_mag INT NOT NULL,
   PRIMARY KEY(num_achat),
   FOREIGN KEY(num_cl) REFERENCES CLIENT(num_cl),
   FOREIGN KEY(num_mag) REFERENCES MAGASIN(num_mag)
);

CREATE TABLE PRODUIT(
   num_prod INT,
   designation_prod VARCHAR(50),
   prix_u_prod DECIMAL(15,2),
   num_fourn INT NOT NULL,
   PRIMARY KEY(num_prod),
   FOREIGN KEY(num_fourn) REFERENCES FOURNISSEUR(num_fourn)
);

CREATE TABLE DIRIGE(
   num_mag INT,
   num_emp INT,
   PRIMARY KEY(num_mag, num_emp),
   FOREIGN KEY(num_mag) REFERENCES MAGASIN(num_mag),
   FOREIGN KEY(num_emp) REFERENCES EMPLOYE(num_emp)
);

CREATE TABLE CONTIENT(
   num_achat INT,
   num_prod INT,
   quantite_achat DECIMAL(15,2),
   PRIMARY KEY(num_achat, num_prod),
   FOREIGN KEY(num_achat) REFERENCES ACHAT(num_achat),
   FOREIGN KEY(num_prod) REFERENCES PRODUIT(num_prod)
);