kubectl delete -f genesis/
kubectl delete -f bootnode/besu-config-toml-configmap-boot.yaml
kubectl delete -f bootnode/bootnode-service.yaml
kubectl delete -f bootnode/bootnode-statefulset.yaml