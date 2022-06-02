kubectl delete -f genesis/
kubectl delete -f tessera/besu-config-toml-configmap-writer-tessera.yaml
kubectl delete -f tessera/writernode-service.yaml
kubectl delete -f tessera/writernode-statefulset.yaml
