#!/bin/bash

iUSER_UID=${iUSER_UID:-$(id -u)}
iUSER_GID=${iUSER_GID:-$(id -g)}
iUSER_NAME=${iUSER_NAME:-${USER}}
iUSER_GROUPS=${iUSER_GROUPS:-$(id -G)}

iGROUP_IDS=''
for g in ${iUSER_GROUPS}; do
  if [ "${g}" == "${iUSER_GID}" ]; then continue; fi
  iGROUP_IDS=${iGROUP_IDS}"""
      - ${g}"""
done

kubectl delete --namespace ${iUSER_NAME} pod/interactive --ignore-not-found

echo "launching interactive pod for ${iUSER_NAME} uid:${iUSER_UID} gid:${iUSER_GID} groups: ${iGROUP_IDS}"

echo """
apiVersion: v1
kind: Pod
metadata:
  name: interactive
  namespace: ${iUSER_NAME}
  labels:
    type: interactive
spec:
  securityContext:
    runAsUser: ${iUSER_UID}
    runAsGroup: ${iUSER_GID}
    supplementalGroups: ${iGROUP_IDS}
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
    - name: interactive
      image: gcr.io/diamond-privreg/controls/gitlab-runners
      # Just spin & wait forever - so a user a can connect with exec
      command: [ \"/bin/bash\", "-c", "--" ]
      args: [ \"while true; do sleep 30; done;\" ]
      resources:
        limits:
          memory: \"128Mi\"
          cpu: \"4\"
        requests:
          memory: \"32Mi\"
          cpu: \"2\"
      volumeMounts:
        - mountPath: /dls_sw
          name: dlssw
          mountPropagation: HostToContainer
        - mountPath: /home
          name: home
          mountPropagation: HostToContainer
      env:
      - name: USER
        value: ${iUSER_NAME}
      - name: HOME
        value: /home/${iUSER_NAME}

""" | kubectl apply -f -

kubectl wait --for=condition=Ready pod/interactive
kubectl exec -it interactive -- bash --init-file /home/${iUSER_NAME}/.bash_profile
kubectl delete pod/interactive
