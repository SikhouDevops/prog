import os

# Suppression du fichier LinuxTest.tf
os.remove('/home/sikhou/Bureau/ProjetLinux/VictorLinux.tf')

# Suppression du fichier terraform.tfvars
os.remove('/home/sikhou/Bureau/ProjetLinux/terraform.tfvars')

# Suppression du fichier variable.tf
os.remove('/home/sikhou/Bureau/ProjetLinux/variable.tf')

# Copie de la template Ec2.tf
os.system('cp /home/sikhou/Bureau/ProjetLinux/Save/Ec2.tf /home/sikhou/Bureau/ProjetLinux/')

# Copie de la template terraform.tfvars
os.system('cp /home/sikhou/Bureau/ProjetLinux/Save/terraform.tfvars /home/sikhou/Bureau/ProjetLinux/')

# Copie de la template variable.tf
os.system('cp /home/sikhou/Bureau/ProjetLinux/Save/variable.tf /home/sikhou/Bureau/ProjetLinux/')

with open('Terraform.csv', 'r') as file:
    lines = file.readlines()
    for line in lines[1:]:
        instancename, description, sggroup, owner, provider = line.strip().split(';')

        AC = instancename.strip()
        DES = description.strip()
        SG = sggroup.strip()
        OWN = owner.strip()
        PRO = provider.strip()

        print("SAC")
        print(AC)
        print(DES)
        print(SG)
        print("SOWN")
        print(PRO)

        print("Traitement des fichiers de configuration Terraform")

        # Modification du fichier terraform.tfvars
        with open('terraform.tfvars', 'r') as tfvars_file:
            tfvars_content = tfvars_file.read()
        tfvars_content = tfvars_content.replace('TestSikhou', AC)
        with open('terraform.tfvars', 'w') as tfvars_file:
            tfvars_file.write(tfvars_content)

        # Modification du fichier variable.tf
        with open('variable.tf', 'r') as variable_file:
            variable_content = variable_file.read()
        variable_content = variable_content.replace('TestSikhou', AC)
        with open('variable.tf', 'w') as variable_file:
            variable_file.write(variable_content)

        print("Création du fichier {}.tf".format(AC))
        with open('template.tf', 'r') as template_file:
            template_content = template_file.read()
        template_content = template_content.replace('*TestSikhou*', AC)
        template_content = template_content.replace('.TestSikhou.', AC)
        template_content = template_content.replace('*Input', DES)
        template_content = template_content.replace('"Sikhou-sg"', SG)
        with open('{}.tf'.format(AC), 'w') as output_file:
            output_file.write(template_content)

        print("Fin de la modification des fichiers")

        # Suppression du fichier EC2 template
        os.remove('Ec2.tf')

        print("Lancement Terraform Init")
        os.system('terraform init')

        print("Lancement Terraform Plan")
        os.system('terraform plan')

        print("Lancement Terraform Apply")
        os.system('terraform apply -auto-approve')

        print("Instance ec2-{} Deployed".format(AC))
        print("Sauvegarde du fichier {}.tf".format(AC))
        os.system('cp /home/sikhou/Bureau/ProjetLinux/VictorLinux.tf /home/sikhou/Bureau/ProjetLinux/TPLinux')
