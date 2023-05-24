#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>

int nbsucces(int essai, char ordi, char joueur) {
    int nbsucces = 0;
    int pourcent = 0;
    
    if (joueur == ordi) {
        printf("\n\t GAGNE\n");
        nbsucces = 1;
    } else {
        printf("\n\t PERDU\n");
        nbsucces = 0;
    }
    
    pourcent = (nbsucces * 100) / essai;
    
    return nbsucces;
}

int pileface(void) {
    char P = 'P', F = 'F';
    char joueur;
    char ordi;
    
    printf("\n\t Pile ou Face");
    printf("\n\t P = pile et F = Face.\n");
    scanf(" %c", &joueur);
    
    int essai = 0;
    int continuer = 1;
    
    while (continuer) {
        if (joueur != P && joueur != F) {
            printf("\n\t P = pile et F = Face.\n");
            scanf(" %c", &joueur);
        }
 
        srand(time(NULL));
        char ordi = rand() % 2 == 0 ? P : F;
 
        if (ordi == P) {
            printf("La piece est tombee sur PILE.\n");
        } else {
            printf("La piece est tombee sur FACE.\n");
        }
        
        essai++;
        
        printf("Voulez-vous continuer a jouer ? (O/N) : ");
        char choix;
        scanf(" %c", &choix);
        
        if (choix == 'N' || choix == 'n') {
            continuer = 0;
        }
    }
    
    return nbsucces(essai, ordi, joueur);
}

void affiche(int essai, char ordi, char joueur) {
    char choix, N = 'N', L = 'L', Q = 'Q';
 
    printf("\t \t Pile ou Face \n");
    printf("\t \t ============ \n \n");
 
    printf("Partie en cours : \n");
    printf("\t Nombre d'essais : %d\n", essai);
    printf("\t Pourcentage de reussite du joueur : %d\n", nbsucces(essai, joueur, ordi));
 
    printf("Menu :\n");
    printf("\t (N) \t Demarrer une Nouvelle partie\n");
    printf("\t (L) \t Lancer La piece\n");
    printf("\t (Q) \t Quitter\n");
    printf("\t \t \t \t \t Choix ?\n");
    scanf(" %c", &choix);
 
    if (choix == N) {
        // Code pour démarrer une nouvelle partie
        // Réinitialiser les variables, par exemple :
        essai = 0;
        ordi = ' ';
        joueur = ' ';
        affiche(essai, ordi, joueur); // Appel récursif pour relancer le jeu
    } else if (choix == L) {
        int resultat = pileface(); // Stocker le résultat retourné par pileface()
        // Traiter le résultat si nécessaire
    } else if (choix == Q) {
        system("CLS");
        // Code pour quitter le jeu
    }
}

void afficheresultat(int essai, char ordi, char joueur) {
    printf("\t \t Pile ou Face \n");
    printf("\t \t ============ \n \n");
 
    printf("Resultat de la derniere partie : ( P = Pile et F = Face)\n\n");
    printf("---------------------------------------------------------------------------\n");
    printf("|Tentative   |   1 |   2 |   3 |   4 |   5 |   6 |   7 |   8 |   9 |   10 |\n");
    printf("---------------------------------------------------------------------------\n");
    printf("|Tirage      |  %c |  %c |  %c |  %c |  %c |  %c |  %c |  %c |  %c |  %c  |\n", ordi, joueur);
    printf("---------------------------------------------------------------------------\n\n");
}

int main() {
    printf("\n\n\n\t\t\t Avez vous de la chance joueons à pile ou face !\n\n");
    
    int essai = 0;
    char ordi = ' ';
    char joueur = ' ';
    
    affiche(essai, ordi, joueur);
    
    return 0;
}
