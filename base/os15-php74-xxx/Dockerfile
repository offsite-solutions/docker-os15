FROM offsite/os15-php74-base:latest

ARG with_xdebug=FALSE
ARG with_composer=FALSE
ARG with_oci8=FALSE
ARG with_pgsql=FALSE
ARG with_sqlsrv=FALSE

COPY install /tmp/install
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

WORKDIR /tmp
RUN if [ "_$with_xdebug" = "_TRUE" ] ; then /usr/local/bin/install_xdebug.sh || exit 1; else printf "# Built with XDEBUG OFF\n" >> /usr/local/bin/env.sh; fi; \
    if [ "_$with_composer" = "_TRUE" ] ; then /usr/local/bin/install_composer.sh || exit 1; else printf "# Built with COMPOSER OFF\n" >> /usr/local/bin/env.sh; fi; \
    if [ "_$with_oci8" = "_TRUE" ] ; then /usr/local/bin/install_oci8.sh || exit 1; else printf "# Built with OCI8 OFF\n" >> /usr/local/bin/env.sh; fi; \
    if [ "_$with_pgsql" = "_TRUE" ] ; then /usr/local/bin/install_pgsql.sh || exit 1; else printf "# Built with PGSQL OFF\n" >> /usr/local/bin/env.sh; fi; \
    if [ "_$with_sqlsrv" = "_TRUE" ] ; then /usr/local/bin/install_sqlsrv.sh || exit 1; else printf "# Built with SQLSRV OFF\n" >> /usr/local/bin/env.sh; fi; \
    zypper --non-interactive clean -a; \
    rm -rf /tmp/*;

EXPOSE 80 443 9010 9050
