# Imagen base
FROM ubuntu:22.04

# Evitar interacción durante instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar paquetes necesarios
RUN apt update && apt install -y \
    openssh-server \
    sudo \
    python3 \
    vim \
    && mkdir /var/run/sshd

# Crear usuario ansible con contraseña ansible
RUN useradd -m -s /bin/bash ansible && echo "ansible:ansible" | chpasswd

# Dar privilegios sudo sin contraseña
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Exponer puerto SSH
EXPOSE 22

# Iniciar el servicio SSH al arrancar el contenedor
CMD ["/usr/sbin/sshd", "-D"]
