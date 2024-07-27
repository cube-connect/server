#include <enet/enet.h>
#include <iostream>
#include <cstdlib>
#include <cstring>

int main(int argc, char** argv) {
    uint16_t port = 7777;
    if (argc > 1) {
        port = static_cast<uint16_t>(std::atoi(argv[1]));
    }

    if (enet_initialize() != 0) {
        std::cerr << "An error occurred while initializing ENet.\n";
        return EXIT_FAILURE;
    }
    atexit(enet_deinitialize);

    ENetAddress address;
    ENetHost* server;

    address.host = ENET_HOST_ANY;
    address.port = port;

    server = enet_host_create(&address, 32, 2, 0, 0);
    if (!server) {
        std::cerr << "An error occurred while trying to create an ENet server host.\n";
        return EXIT_FAILURE;
    }

    std::cout << "Server initialized on port " << port << ".\n";

    ENetEvent event;
    while (true) {
        while (enet_host_service(server, &event, 0) > 0) {
            switch (event.type) {
                case ENET_EVENT_TYPE_CONNECT:
                    std::cout << "A new client connected from "
                              << event.peer->address.host << ":"
                              << event.peer->address.port << ".\n";
                    event.peer->data = (void*)"Client information";
                    break;
                case ENET_EVENT_TYPE_RECEIVE:
                    std::cout << "A packet of length " << event.packet->dataLength
                              << " containing " << (char*)event.packet->data
                              << " was received from " << (char*)event.peer->data
                              << " on channel " << event.channelID << ".\n";
                    enet_packet_destroy(event.packet);
                    break;
                case ENET_EVENT_TYPE_DISCONNECT:
                    std::cout << (char*)event.peer->data << " disconnected.\n";
                    event.peer->data = nullptr;
                    break;
                default:
                    break;
            }
        }

        // Send data to all connected peers at the end of the service loop
        const char* message = "Server message at the end of the service loop";
        ENetPacket* packet = enet_packet_create(message, strlen(message) + 1, ENET_PACKET_FLAG_RELIABLE);

        for (size_t i = 0; i < server->peerCount; ++i) {
            ENetPeer* peer = &server->peers[i];
            if (peer->state == ENET_PEER_STATE_CONNECTED) {
                enet_peer_send(peer, 0, packet);
            }
        }

        enet_host_flush(server);
    }

    enet_host_destroy(server);
    return EXIT_SUCCESS;
}