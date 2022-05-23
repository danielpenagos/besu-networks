kubectl delete -f namespace/
kubectl delete -f genesis/
kubectl delete -f validator/besu-config-toml-configmap-validator.yaml
kubectl delete -f validator/validator-service.yaml
kubectl delete -f validator/validator-statefulset.yaml