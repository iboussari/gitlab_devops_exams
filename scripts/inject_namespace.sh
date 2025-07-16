#!/bin/bash

# Vérification des arguments
if [ $# -ne 2 ]; then
  echo "Usage : $0 <chemin_du_dossier> <namespace>"
  exit 1
fi

DOSSIER="$1"
NAMESPACE="$2"

echo "📁 Dossier : $DOSSIER"
echo "�� Namespace : $NAMESPACE"

# Parcourt tous les fichiers YAML du dossier
for FILE in "$DOSSIER"/*.yaml; do
  echo "🔄 Modification du fichier : $FILE"

  # Vérifie si namespace est déjà présent
  if grep -q "namespace:" "$FILE"; then
    # Remplace le namespace existant
    sed -i "s/namespace: .*/namespace: $NAMESPACE/" "$FILE"
  else
    # Ajoute la ligne namespace sous metadata:
    sed -i "/metadata:/a \ \ namespace: $NAMESPACE" "$FILE"
  fi
done

echo "✅ Tous les fichiers ont été mis à jour avec le namespace \"$NAMESPACE\"."
