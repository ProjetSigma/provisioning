# Provisioning
Provisioning for Projet Sigma server

## Getting started
The setup expects the project layout to be like the following:

    sigma/
      +- provisioning/
      +- backend/
      +- frontend/

To create and provision the vagrant:

    vagrant up

Then, log in the vagrant:

    vagrant ssh

The directory `/vagrant` will be synced with your `sigma` folder.

To fire up the server:

    cd /vagrant/backend
    python3 manage.py runserver_plus 0.0.0.0:8000

to launch the client:

    cd /vagrant/frontend
    npm start

The backend and frontend will then be available at localhost:8000 and localhost:5555 on your host machine, and you can start coding as usual !

To reprovision the vagrant in case provisioning changed:

    vagrant provision

and/or

    vagrant reload
