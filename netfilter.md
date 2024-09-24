# NAT连接追踪  

### Connection Tracking 概述
`conntrack` 是内核中的一个状态跟踪模块，位于网络栈的 `Netfilter` 框架中。它在数据包从内核网络栈的不同钩子点（hooks）中穿过时，记录连接的状态，以便对连接的每个数据包做出正确的 NAT 转换或过滤操作。

### 关键模块和代码路径
Linux 内核中的 NAT 和 Connection Tracking 主要涉及以下几个模块：
- **Netfilter（`net/netfilter/`）**：处理包过滤、连接跟踪和 NAT。
- **nf_conntrack（`net/netfilter/nf_conntrack_core.c`）**：连接追踪的核心模块。
- **nf_nat（`net/netfilter/nf_nat_core.c`）**：NAT 转换的核心模块。
- **协议相关的模块**（如 `nf_conntrack_proto_tcp.c`、`nf_conntrack_proto_udp.c`）处理 TCP 和 UDP 连接。

### 数据包处理流程

1. **Netfilter 钩子点**：
   Netfilter 在网络数据包的不同处理阶段提供了多个钩子点（`PRE_ROUTING`, `POST_ROUTING`, `FORWARD`, `INPUT`, `OUTPUT`）。当数据包通过这些钩子点时，可以对其进行 NAT 处理或状态跟踪。
   
   主要的钩子点包括：
   - **`NF_INET_PRE_ROUTING`**：在数据包刚进入时进行处理（适用于从外部进入的包）。
   - **`NF_INET_POST_ROUTING`**：在包要离开网络接口时处理（适用于发往外部的包）。

2. **Conntrack 初始化与数据包关联**：
   当一个数据包进入网络栈时，conntrack 会在 `nf_conntrack_in()` 函数中处理它。此函数负责：
   - 查找或创建一个 **连接追踪条目**（`struct nf_conn`）。
   - 如果条目不存在（意味着是一个新的连接），则调用协议相关的 conntrack 模块（如 `nf_conntrack_proto_tcp.c` 或 `nf_conntrack_proto_udp.c`）来初始化连接条目。
   - 连接条目会记录数据包的源地址、目标地址、端口、状态、NAT 映射信息等。

   相关代码位于 `net/netfilter/nf_conntrack_core.c` 文件中的 `nf_conntrack_in()` 函数。

3. **NAT 转换**：
   如果连接需要进行 NAT 转换，`nf_nat_core.c` 中的代码会被调用。NAT 模块根据之前的 NAT 规则或策略决定如何修改数据包的 IP 地址和端口，并更新连接追踪条目中的 NAT 信息。
   
   主要代码可以参考 `net/netfilter/nf_nat_core.c` 中的 `nf_nat_packet()` 函数。

4. **连接状态的跟踪**：
   conntrack 模块会持续跟踪每个连接的状态变化（如 TCP 连接的 SYN、ACK、FIN 状态），并将这些状态保存在 `struct nf_conn` 结构中。`nf_conntrack_proto_tcp.c` 和 `nf_conntrack_proto_udp.c` 分别处理 TCP 和 UDP 的状态跟踪。
   
   代码路径：
   - TCP 的状态跟踪在 `net/netfilter/nf_conntrack_proto_tcp.c` 文件的 `tcp_packet()` 函数中。
   - UDP 的状态跟踪在 `net/netfilter/nf_conntrack_proto_udp.c` 文件的 `udp_packet()` 函数中。

5. **Connection Tracking 超时和清理**：
   Linux 内核会定期检查连接追踪表，清理超时或无效的连接。不同协议的连接超时不同，比如 TCP 连接在 `CLOSE` 状态下可能会保持一段时间，UDP 连接则有较短的超时时间。
   
   超时管理和连接清理的相关代码在 `net/netfilter/nf_conntrack_core.c` 文件中实现，尤其是 `nf_ct_gc_expired()` 函数。

### 主要的数据结构
- **`struct nf_conn`**：这是每个连接的核心数据结构，记录了连接的源 IP、目标 IP、源端口、目标端口、协议类型、NAT 映射信息、连接状态等。
- **`struct nf_conntrack_tuple`**：用于唯一标识一个连接，包含五元组（源 IP、目的 IP、源端口、目的端口、协议）。
- **`struct nf_conntrack_l3proto`** 和 **`struct nf_conntrack_l4proto`**：分别负责处理 L3（如 IPv4、IPv6）和 L4（如 TCP、UDP）的连接追踪。

### 代码阅读路径
要深入学习 Linux 内核中的 NAT 连接追踪，建议按照以下路径来阅读代码：
1. **Netfilter 框架概述**：
   - `include/linux/netfilter.h`：定义了 Netfilter 的钩子点和相关数据结构。
   - `net/netfilter/core.c`：Netfilter 框架的核心实现。
   
2. **Conntrack 模块**：
   - `net/netfilter/nf_conntrack_core.c`：连接追踪的核心逻辑。
   - `include/net/netfilter/nf_conntrack.h`：定义了连接追踪的核心数据结构和函数。
   
3. **NAT 模块**：
   - `net/netfilter/nf_nat_core.c`：NAT 相关的处理逻辑。
   - `include/net/netfilter/nf_nat.h`：NAT 数据结构和函数的定义。

4. **协议相关模块**：
   - `net/netfilter/nf_conntrack_proto_tcp.c`：处理 TCP 协议的连接追踪。
   - `net/netfilter/nf_conntrack_proto_udp.c`：处理 UDP 协议的连接追踪。
