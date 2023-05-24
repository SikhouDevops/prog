echo "Suppression du fichier LinuxTest.tf"
rm 'C:\Users\Sikhou\Bureau\Projet Linux\LinuxTest.tf'

echo "Suppression du fichier terraform.tfvars"
rm 'C:\Users\Sikhou\Bureau\Projet Linux\terraform.tfvars'

echo "Suppression du fichier variable.tf"
rm 'C:\Users\Sikhou\Bureau\Projet Linux\variable.tf'

echo "Copie de la template Ec2.tf"
cp 'C:\Users\Sikhou\Bureau\Projet Linux\Save\Ec2.tf' 'C:\Users\Sikhou\Bureau\Projet Linux'

echo "Copie de la template terraform.tfvars"
cp 'C:\Users\Sikhou\Bureau\Projet Linux\Save\terraform.tfvars' 'C:\Users\Sikhou\Bureau\Projet Linux'

echo "Copie de la template variable.tf"
cp 'C:\Users\Sikhou\Bureau\Projet Linux\Save\variable.tf' 'C:\Users\Sikhou\Bureau\Projet Linux'

sed 1d "Terraform.csv" | while IFS=';' read -r instancename description sggroup owner; do
    line="$instancename $description $sggroup"
    
    AC=$(echo $instancename)
    DES=$(echo $description)
    SG=$(echo $sggroup)
    OWN=$(echo $owner)

    echo "$AC"
    echo "$DES"
    echo "$SG"
    echo "$OWN"


    echo "Traitement des fichiers de configuration Terraform"
    echo "Modification du fichier Terraform.tfvars"
    sed -i "s/TestSikhou/$AC/g" terraform.tfvars

    echo "Modification du fichier variable.tf"
    sed -i "s/TestSikhou/$AC/g" variable.tf

    echo "Création du fichier $AC.tf"
    sed -e "s/""TestSikhou""/$AC/g" -e "s/.TestSikhou./$AC/g" -e "s/""Input""/$DES/g" -e "s/""Sikhou-sg""/$SG/g" -e "s/azure/$OWN/g" <EC2.tf >$AC.tf
    
    echo "Fin de la modification des fichiers"
    
    echo "Suppression du fichier EC2 template"
    rm Ec2.tf
    
    echo "Lancement Terraform Init"
    terraform init
    
    echo "Lancement Terraform Plan"
    terraform plan
    
    echo "Lancement Terraform Apply"
    terraform apply -auto-approve

    echo "Instance ec2-$AC Deployed"

    echo "Sauvegarde du fichier $AC.tf"
    cp 'C:\Users\Sikhou\Bureau\Projet Linux\LinuxTest.tf' 'C:\Users\Sikhou\Bureau\Projet Linux\TP Linux'

done

echo "Ce n'est pas fini"
echo "Allons sur AWS :D"
#xdg-open https://us-east-1.console.aws.amazon.com/ec2/v2/home?region=us-east-1#AMICatalog:

