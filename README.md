#  Setup

This repository contains a Makefile that automates the setup of a PostgreSQL database in a Kind cluster. The following dependencies are required:

- [Kind](https://kind.sigs.k8s.io/)
- [Docker](https://www.docker.com/)
- [Make](https://www.gnu.org/software/make/)

To create the Kind cluster and deploy the database, run:

```
make setup-all
```

This will create a Kind cluster, deploy a PostgreSQL instance, create a database and a user, and run a SQL script to initialize the schema. It will also deploy [SchemaSpy](https://schemaspy.org/) to generate a database schema visualization.

To access the database, run:

```
make connect-db
```

This will open a PostgreSQL shell in the database container.

To tear down the Kind cluster, run:

```
make teardown
```
This will delete the Kind cluster and all its resources.


To view the generated documentation from SchemaSpy, you can run

```
make port-forward
```

and navigate to 127.0.0.1:8080 in your browser to browse the documentation.


Note that the Makefile assumes that Docker is running and that the `kind` and `kubectl` commands are available in the PATH.

