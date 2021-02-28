#!/usr/bin/env python3
# compacta un fichero EPL:
# - Eliminado el schema
# - Reemplazando las expresiones en linea
# - Reemplazando los saltos de linea por espacios

import sys
import logging
import json
import re

def eplFormat(epl):
    """Normaliza un comando EPL para poder usar en la API de CEP"""
    # Replace newlines by spaces, just in case
    epl = " ".join(epl.replace("\r\n", "\n").split())
    # Remove "create schema", not used by CEP
    epl = re.sub("create schema [^;]+;", "", epl)
    # Match expression (xxx) alias for { (...) }
    exprRegexp = re.compile("expression\s+([\w\d]+)\s+alias\s+for\s+{([^{]+)}")
    while True:
        expr = exprRegexp.search(epl)
        # When no more expressions to replace, return
        if not expr:
            logging.info("No more expression matches for EPL %s", epl)
            return epl.strip()
        # If there is a match, truncate EPL and replace alias
        alias = expr.group(1)
        inner = expr.group(2)
        logging.info("Replacing expression %s with %s", alias, inner)
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
        epl = eplfile.read()
    print(json.dumps(eplFormat(epl)))
