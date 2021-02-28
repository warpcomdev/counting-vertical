#!/usr/bin/env python3
# Copyright 2021 Telefónica Soluciones de Informática y Comunicaciones de España, S.A.U.
# PROJECT: Urbo2
#
# This software and / or computer program has been developed by Telefónica Soluciones
# de Informática y Comunicaciones de España, S.A.U (hereinafter TSOL) and is protected
# as copyright by the applicable legislation on intellectual property.
#
# It belongs to TSOL, and / or its licensors, the exclusive rights of reproduction,
# distribution, public communication and transformation, and any economic right on it,
# all without prejudice of the moral rights of the authors mentioned above. It is expressly
# forbidden to decompile, disassemble, reverse engineer, sublicense or otherwise transmit
# by any means, translate or create derivative works of the software and / or computer
# programs, and perform with respect to all or part of such programs, any type of exploitation.
#
# Any use of all or part of the software and / or computer program will require the
# express written consent of TSOL. In all cases, it will be necessary to make
# an express reference to TSOL ownership in the software and / or computer
# program.
#
# Non-fulfillment of the provisions set forth herein and, in general, any violation of
# the peaceful possession and ownership of these rights will be prosecuted by the means
# provided in both Spanish and international law. TSOL reserves any civil or
# criminal actions it may exercise to protect its rights.
#
# compacta un fichero EPL:
# - Eliminado el schema
# - Reemplazando las expresiones en linea
# - Reemplazando los saltos de linea por espacios

import sys
import logging
import json
import re

def eplFormat(eplLines):
    """Normaliza un comando EPL para poder usar en la API de CEP"""
    # Split epl in lines and remove line-based comments
    lines = (line.strip() for line in eplLines)
    lines = (line.split("//", 2)[0].strip() for line in lines if not line.startswith("//"))
    lines = (line for line in lines if line)
    # Replace newlines by spaces, just in case
    epl = " ".join(lines)
    # Remove slash-star comments
    epl = re.sub("/\*.*\*/", "", epl)
    # Remove "create schema", not used by CEP
    epl = re.sub("create schema [^;]+;", "", epl)
    # Match expression (xxx) alias for { (...) }
    exprRegexp = re.compile("expression\s+([\w\d]+)\s+alias\s+for\s+{([^{]+)}")
    while True:
        expr = exprRegexp.search(epl)
        # When no more expressions to replace, return
        if not expr:
            logging.debug("No more expression matches for EPL %s", epl)
            return epl.strip()
        # If there is a match, truncate EPL and replace alias
        alias = expr.group(1)
        inner = expr.group(2)
        logging.debug("Replacing expression %s with %s", alias, inner)
        epl = epl[expr.end():]
        epl = epl.replace("%s()" % alias, inner)
        epl = epl.replace(alias, inner)


if __name__ == "__main__":
    import argparse

    logging.basicConfig(level=logging.WARNING)
    parser = argparse.ArgumentParser(description="Preprocesa una regla EPL para utilizarla en perseo CEP.")
    parser.add_argument("eplFile", help="Nombre del fichero EPL a procesar")
    args = parser.parse_args()

    with open(args.eplFile, "r", encoding="utf-8") as eplfile:
        eplLines = eplfile.readlines()
    print(json.dumps(eplFormat(eplLines)))
