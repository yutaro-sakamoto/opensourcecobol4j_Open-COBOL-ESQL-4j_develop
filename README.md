# The development environment of opensource COBOL 4J and Open COBOL ESQL 4J

This repository maintains docker containers for developers of [opensource COBOL 4J](https://github.com/opensourcecobol/opensourcecobol4j) and [Open COBOL ESQL 4J](https://github.com/opensourcecobol/Open-COBOL-ESQL-4j), not users of them.

The development environment consists of `oc4j_client` container with opensource COBOL 4J and Open COBOL ESQL 4J installed and `oc4j_db` container in which PostgreSQL server runs.

# Usage

* Run `docker compuse up -d` to launch docker containers.
* Run `docker attach oc4j_client` to attach the container with opensource COBOL 4J and Open COBOL ESQL 4J installed.
* You will find `~/opensourcecobol4` and `~/Open-COBOL-ESQL-4j` created by `git clone` command.
  * Use `git remote` command to configure tracked repositories if necessary.
* Enjoy developping opensource COBOL 4J and Open COBOL ESQL 4J!