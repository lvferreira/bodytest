***Settings***
Documentation      Tudo comeca aqui, meu arquivo base do projeto de automação BodyTest

Library         Browser
Library         Collections
Library         OperatingSystem
Library         DateTime
Library         libs/DeloreanLibrary.py

Resource        actions/auth.robot
Resource        actions/nav.robot
Resource        actions/students.robot
Resource        actions/components.robot
Resource        actions/plans.robot
Resource        actions/enrolls.robot

Resource        helpers.robot

*** Variables ***
${timeout}      2

***Keywords***
Start Browser Session
    New Browser     chromium    True
    New Page        about:blank

User Session
    Start Browser Session
    Go To Login Page
    Login With                   admin@bodytest.com     pwd123
    User Should Be Logged In     Administrador

Clear LS
    Take Screenshot
    LocalStorage Clear

ThinkTime
    Sleep           ${timeout}
    Take Screenshot


 