# Generate image Docker to deploy nodes besu Lacnet.

* Below you will find instructions for the compile image docker for nodes besu, relay signer, nginx proxy and tessera.


* **Besu image**
Generate a image besu with the following command:

    ```shell
    $ ./image-besu.sh
    ```
* **Relay signer image**
Generate a image relay signer with the following command:

    ```shell
    $ ./image-relay-signer.sh
    ```
* **Nginx image**
Generate a image nginx proxy reverse to writer node with the following command:

    ```shell
    $ ./image-nginx-writer.sh
    ```
* **Tessera image**
Generate a image tessera with the following command:

    ```shell
    $ ./image-tessera.sh
    ```

* Push image to Docker hub 
     ```shell
    $ docker push lacnetnetworks/lacchain-besu:21.1.6
     ```