#!/bin/bash

kubectl delete pod/interactive --ignore-not-found

echo """
apiVersion: v1
kind: Pod
metadata:
  name: interactive
  namespace: hgv27681
  labels:
    type: interactive
spec:
  securityContext:
    runAsUser: $(id -u)
    runAsGroup: $(id -g)
    supplementalGroups:
      # groups dls_bl_cs, dcs
      - 37715
      - 500
  volumes:
    - name: dlssw
      hostPath:
        path: /dls_sw
        type: Directory
    - name: home
      hostPath:
        path: /home
        type: Directory
  containers:
    - name: runner
      image: gcr.io/diamond-privreg/controls/gitlab-runners:latest
      # Just spin & wait forever - so a user a can connect with exec
      command: [ \"/bin/bash\", "-c", "--" ]
      args: [ \"while true; do sleep 30; done;\" ]
      resources:
        limits:
          memory: \"128Mi\"
          cpu: \"500m\"
      volumeMounts:
        - mountPath: /dls_sw
          name: dlssw
          mountPropagation: HostToContainer
        - mountPath: /home
          name: home
          mountPropagation: HostToContainer
      env:
      - name: HOME
        value: ${USER}
      - name: USER
        value: ${HOME}


""" | kubectl apply -f -

kubectl exec -it interactive -- --init-file ${HOME}/.bash_profile
kubectl delete pod/interactive
