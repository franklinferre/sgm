# Salvar parâmetros atuais como referência de valores alterados:
sysctl -a  2>/dev/null >  /etc/backup-sysctl.conf;

# HugePages - deixei comentado pois depende do
# - volume de RAM
# - tamanho padrao da hugepage
# - espaço total a ser reservado
#(
#    echo  "vm.nr_hugepages=8192"
#)  >  /etc/sysctl.d/040-hugepages.conf

# Liberar mais RAM para aceleração de rede
(
    echo  "net.core.rmem_default=31457280"
    echo  "net.core.wmem_default=31457280"
    echo  "net.core.rmem_max=134217728"
    echo  "net.core.wmem_max=134217728"
    echo  "net.core.netdev_max_backlog=250000"
    echo  "net.core.optmem_max=33554432"
    echo  "net.core.default_qdisc=fq"
    echo  "net.core.somaxconn=4096"
)  >  /etc/sysctl.d/051-net-core.conf;

# Aumentar capacidades de rede do protocolo TCP
(
    echo "net.ipv4.tcp_sack = 1"
    echo "net.ipv4.tcp_timestamps = 1"
    echo "net.ipv4.tcp_low_latency = 1"
    echo "net.ipv4.tcp_max_syn_backlog = 8192"
    echo "net.ipv4.tcp_rmem = 4096 87380 67108864"
    echo "net.ipv4.tcp_wmem = 4096 65536 67108864"
    echo "net.ipv4.tcp_mem = 6672016 6682016 7185248"
    echo "net.ipv4.tcp_congestion_control=htcp"
    echo "net.ipv4.tcp_mtu_probing=1"
    echo "net.ipv4.tcp_moderate_rcvbuf =1"
    echo "net.ipv4.tcp_no_metrics_save = 1"
)  >  /etc/sysctl.d/052-net-tcp-ipv4.conf;

# Aumentando a faixa de portas de origem (usar toda faixa de portas altas)
(
    echo "net.ipv4.ip_local_port_range=1024 65535"
) >  /etc/sysctl.d/056-port-range-ipv4.conf;

# TTL padrão dos pacotes IPv4
(
    echo "net.ipv4.ip_default_ttl=128"
) >  /etc/sysctl.d/062-default-ttl-ipv4.conf;


# Ajustes de ARP e fragmentacao (maior capacidade) - IPv4
(
    echo "net.ipv4.neigh.default.gc_interval = 30"
    echo "net.ipv4.neigh.default.gc_stale_time = 60"
    echo "net.ipv4.neigh.default.gc_thresh1 = 4096"
    echo "net.ipv4.neigh.default.gc_thresh2 = 8192"
    echo "net.ipv4.neigh.default.gc_thresh3 = 12288"
    echo
    echo "net.ipv4.ipfrag_high_thresh=4194304"
    echo "net.ipv4.ipfrag_low_thresh=3145728"
    echo "net.ipv4.ipfrag_max_dist=64"
    echo "net.ipv4.ipfrag_secret_interval=0"
    echo "net.ipv4.ipfrag_time=30"
)  >  /etc/sysctl.d/063-neigh-ipv4.conf;

# Ajustes de ARP e fragmentacao (maior capacidade) - IPv6
(
    echo "net.ipv6.neigh.default.gc_interval = 30"
    echo "net.ipv6.neigh.default.gc_stale_time = 60"
    echo "net.ipv6.neigh.default.gc_thresh1 = 4096"
    echo "net.ipv6.neigh.default.gc_thresh2 = 8192"
    echo "net.ipv6.neigh.default.gc_thresh3 = 12288"
    echo
    echo "net.ipv6.ip6frag_high_thresh=4194304"
    echo "net.ipv6.ip6frag_low_thresh=3145728"
    echo "net.ipv6.ip6frag_secret_interval=0"
    echo "net.ipv6.ip6frag_time=60"
)  >  /etc/sysctl.d/064-neigh-ipv6.conf;

# Ativar roteamento de pacotes IPv4
(
    echo  "net.ipv4.conf.default.forwarding=1"
)  >  /etc/sysctl.d/065-default-foward-ipv4.conf;

# Ativar roteamento de pacotes IPv6
(
    echo  "net.ipv6.conf.default.forwarding=1"
) >  /etc/sysctl.d/066-default-foward-ipv6.conf;

# Ativar roteamento em todas as interfaces de rede
echo  "net.ipv4.conf.all.forwarding=1"   >  /etc/sysctl.d/067-all-foward-ipv4.conf
echo  "net.ipv6.conf.all.forwarding=1"   >  /etc/sysctl.d/068-all-foward-ipv6.conf
echo  "net.ipv4.ip_forward=1"            >  /etc/sysctl.d/069-ipv4-forward.conf

# Aumentar capacidades de arquivos abertos
(
    echo "fs.file-max=26110208"
    echo "fs.aio-max-nr=3263776"
    echo "fs.mount-max=1048576"
    echo "fs.mqueue.msg_max=128"
    echo "fs.mqueue.msgsize_max=131072"
    echo "fs.mqueue.queues_max=4096"
    echo "fs.pipe-max-size=8388608"
)  >  /etc/sysctl.d/072-fs-options.conf;

# Nao usar SWAP enquanto houver memoria RAM livre
echo  "vm.swappiness=0"            >  /etc/sysctl.d/073-swappiness.conf;

# Usar mais RAM para priorizar metadados de sistema de arquivos
echo  "vm.vfs_cache_pressure=50"   >  /etc/sysctl.d/074-vfs-cache-pressure.conf;

# Reiniciar o kernel apos 3 segundos em caso de pane geral
echo  "kernel.panic=3"             >  /etc/sysctl.d/081-kernel-panic.conf;

# Aumentar limite de threads por processo (vital para NODE.js e accel-ppp)
echo  "kernel.threads-max=1031306" >  /etc/sysctl.d/082-kernel-threads.conf;

# Aumentar limite de processos rodando paralelamente
echo  "kernel.pid_max=262144"      >  /etc/sysctl.d/083-kernel-pid.conf;

# Tamanho de buffer de mensagens de sistema (SYSCALL)
echo  "kernel.msgmax=327680"       >  /etc/sysctl.d/084-kernel-msgmax.conf;
echo  "kernel.msgmnb=655360"       >  /etc/sysctl.d/085-kernel-msgmnb.conf;
echo  "kernel.msgmni=32768"        >  /etc/sysctl.d/086-kernel-msgmni.conf;

# CRITICO: 
# - Quantidade de RAM reservada pelo kernel para operacoes criticas
# - Requer tabela de acordo com quantidade de RAM:
#   Ex.:
#     abaixo de 4GB......:  32 MB
#     entre 8 GB e 32 GB.: 128 MB
#     32GB ou mais.......: 512 MB
#
# echo  "vm.min_free_kbytes = 32768" >  /etc/sysctl.d/087-kernel-free-min-kb.conf


# Conntrack
#----------------------------------------------------------

# Permitir ate 8 milhoes de registros de NAT/Redirecionamento/CGNAT
(
    echo "net.nf_conntrack_max=8000000"  # 262144
) >  /etc/sysctl.d/090-netfilter-max.conf;

# Aumentar tabela de controle da conntrack
(
    echo "net.netfilter.nf_conntrack_buckets=262144"
    echo "net.netfilter.nf_conntrack_checksum=1"
    echo "net.netfilter.nf_conntrack_events = 1"
    echo "net.netfilter.nf_conntrack_expect_max = 1024"
    echo "net.netfilter.nf_conntrack_timestamp = 0"
) >  /etc/sysctl.d/091-netfilter-generic.conf;

# Ativar helpers (ALG de NAT/CGNAT)
(
    echo "net.netfilter.nf_conntrack_helper=1"
) > /etc/sysctl.d/092-netfilter-helper.conf;

# Esquecer registros ICMP apos 30 segundos sem atividade
(
    echo "net.netfilter.nf_conntrack_icmp_timeout=30"
    echo "net.netfilter.nf_conntrack_icmpv6_timeout=30"
) >  /etc/sysctl.d/093-netfilter-icmp.conf;

# Esquecer registros TCP apos um tempo minimamente toleravel sem atividade
(
    echo "net.netfilter.nf_conntrack_tcp_be_liberal=0"
    echo "net.netfilter.nf_conntrack_tcp_loose=1"
    echo "net.netfilter.nf_conntrack_tcp_max_retrans=3"
    echo "net.netfilter.nf_conntrack_tcp_timeout_close=10"
    echo "net.netfilter.nf_conntrack_tcp_timeout_close_wait=10" #60
    echo "net.netfilter.nf_conntrack_tcp_timeout_established=600" #432000
    echo "net.netfilter.nf_conntrack_tcp_timeout_fin_wait=10" #120
    echo "net.netfilter.nf_conntrack_tcp_timeout_last_ack=10" #30
    echo "net.netfilter.nf_conntrack_tcp_timeout_max_retrans=60" #300
    echo "net.netfilter.nf_conntrack_tcp_timeout_syn_recv=5" #60
    echo "net.netfilter.nf_conntrack_tcp_timeout_syn_sent=5" #60
    echo "net.netfilter.nf_conntrack_tcp_timeout_time_wait=30" #120
    echo "net.netfilter.nf_conntrack_tcp_timeout_unacknowledged=300"
)  >  /etc/sysctl.d/094-netfilter-tcp.conf;

# Esquecer registros UDP apos 30 segundos sem atividade, 180s para stream
(
    echo "net.netfilter.nf_conntrack_udp_timeout=30"
    echo "net.netfilter.nf_conntrack_udp_timeout_stream=180"
)  >  /etc/sysctl.d/095-netfilter-udp.conf;

# Opcoes de SCTP (pouco usado, opcional)
(
    echo "net.netfilter.nf_conntrack_sctp_timeout_closed=10"
    echo "net.netfilter.nf_conntrack_sctp_timeout_cookie_echoed=3"
    echo "net.netfilter.nf_conntrack_sctp_timeout_cookie_wait=3"
    echo "net.netfilter.nf_conntrack_sctp_timeout_established=432000"
    echo "net.netfilter.nf_conntrack_sctp_timeout_heartbeat_acked=210"
    echo "net.netfilter.nf_conntrack_sctp_timeout_heartbeat_sent=30"
    echo "net.netfilter.nf_conntrack_sctp_timeout_shutdown_ack_sent=3"
    echo "net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd=0"
    echo "net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent=0"
)  >  /etc/sysctl.d/096-netfilter-sctp.conf;

# Opcoes de DCCP (pouco usado, opcional)
(
    echo "net.netfilter.nf_conntrack_dccp_loose=1"
    echo "net.netfilter.nf_conntrack_dccp_timeout_closereq=64"
    echo "net.netfilter.nf_conntrack_dccp_timeout_closing=64"
    echo "net.netfilter.nf_conntrack_dccp_timeout_open=43200"
    echo "net.netfilter.nf_conntrack_dccp_timeout_partopen=480"
    echo "net.netfilter.nf_conntrack_dccp_timeout_request=240"
    echo "net.netfilter.nf_conntrack_dccp_timeout_respond=480"
    echo "net.netfilter.nf_conntrack_dccp_timeout_timewait=240"
)  >  /etc/sysctl.d/097-netfilter-dccp.conf;

# Controle de fragmentacao de pacotes IPv6 (sim, existe!)
(
    echo "net.netfilter.nf_conntrack_frag6_high_thresh=4194304"
    echo "net.netfilter.nf_conntrack_frag6_low_thresh=3145728"
    echo "net.netfilter.nf_conntrack_frag6_timeout=60"
)  >  /etc/sysctl.d/099-netfilter-ipv6.conf;


# Aplicar imediatamente:
sysctl -q --system  2>/dev/null;
sysctl -q -p        2>/dev/null;

# Alpine: requer tudo em um unico arquivo:
grep -iq alpine /etc/os-release && cat /etc/sysctl.d/*.conf > /etc/sysctl.conf;
