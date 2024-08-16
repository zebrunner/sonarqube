SonarQube
==================

SonarQube (formerly Sonar) is an open-source platform for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells, and security vulnerabilities on 20+ programming languages. SonarQube offers reports on duplicated code, coding standards, unit tests, code coverage, code complexity, comments, bugs, and security vulnerabilities.
It can record metrics history and provides evolution graphs. Provides fully automated analysis and integration with Maven, Ant, Gradle, MSBuild and continuous integration tools (Atlassian Bamboo, Jenkins, Hudson, etc.).

Zebrunner SonarQube image is pre-configured SonarQube v9.8 with [community branch plugin](https://github.com/mc1arke/sonarqube-community-branch-plugin) installed for static code analysis.

It is fully integrated into the Zebrunner Community Edition Server pipeline for Test Automation code inspection and user's guidelines.

Detailed configuration steps can be found [here](https://zebrunner.github.io/community-edition/config-guide/#sonarqube-integration).

Feel free to support the development with a [**donation**](https://www.paypal.com/donate/?hosted_button_id=MNHYYCYHAKUVA) for the next improvements.

<p align="center">
  <a href="https://zebrunner.com/"><img alt="Zebrunner" src="https://github.com/zebrunner/zebrunner/raw/master/docs/img/zebrunner_intro.png"></a>
</p>

## Hardware requirements

|                         	| Requirements                                                     	|
|:-----------------------:	|------------------------------------------------------------------	|
| <b>Operating System</b> 	| Ubuntu 16.04 - 22.10<br>Linux CentOS 7+<br>Amazon Linux 2 	      |
| <b>       CPU      </b> 	| 2+ Cores                                                         	|
| <b>      Memory    </b> 	| 8 Gb RAM                                                        	|
| <b>    Free space  </b> 	| SSD 64Gb+ of free space                                         	|

## Software requirements

* Install docker ([Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04), [Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04), [Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04), [Amazon Linux 2](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html), [Redhat/Cent OS](https://www.cyberciti.biz/faq/install-use-setup-docker-on-rhel7-centos7-linux/))
  
* Install [docker-composer](https://docs.docker.com/compose/install/#install-compose) 1.25.5+

* Install git 2.20.0+

## Initial setup
1. Clone [Sonarqube](https://github.com/zebrunner/sonarqube) and start:
   ```
   git clone https://github.com/zebrunner/sonarqube.git && cd sonarqube && ./zebrunner.sh start
   ```
2. After the startup, SonarQube be available:
   > Use your host address instead of `hostname`!  
  
| Component            | URL                                                                |
|---------------------  | ------------------------------------------------------------------ |
| SonarQube             | [http://hostname:9000/sonarqube](http://hostname:9000/sonarqube)             |

  > admin/admin crendetials should be used.


## Documentation and free support
* [Zebrunner PRO](https://zebrunner.com)
* [Zebrunner CE](https://zebrunner.github.io/community-edition)
* [Zebrunner Reporting](https://zebrunner.com/documentation)
* [Carina Guide](http://zebrunner.github.io/carina)
* [Demo Project](https://github.com/zebrunner/carina-demo)
* [Telegram Channel](https://t.me/zebrunner)

