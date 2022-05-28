kubectl delete -f genesis/
kubectl delete -f writer/besu-config-toml-configmap-writer.yaml
kubectl delete -f writer/writernode-service.yaml
kubectl delete -f writer/writernode-statefulset.yaml