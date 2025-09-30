from collections import defaultdict
from collections.abc import Callable
from dataclasses import dataclass
import heapq
from typing import TypeAlias


@dataclass
class NodePath:
    path: list[str]
    cost: float


@dataclass
class Adjacency:
    target: str
    cost: float


HeuristicFn: TypeAlias = Callable[[str], float]


class Graph:
    def __init__(self):
        self.adjacency_list: dict[str, list[Adjacency]] = defaultdict(list)

    def add_edge(self, u: str, v: str, cost: float, bidirectional: bool = True):
        self.adjacency_list[u].append(Adjacency(target=v, cost=cost))
        if bidirectional:
            self.adjacency_list[v].append(Adjacency(target=u, cost=cost))

    def add_edges(self, edges: list[tuple[str, str, float]], bidirectional: bool = True):
        for u, v, cost in edges:
            self.add_edge(u, v, cost, bidirectional=bidirectional)

    @staticmethod
    def _default_heuristic(u: str) -> float:
        return 0

    # Using Uniform Cost Search
    def get_shortest_path(
        self, s: str, t: str, heuristic: HeuristicFn | None = None
    ) -> NodePath | None:
        if not heuristic:
            heuristic = self._default_heuristic

        # Priority queue: (f(u), u, g(u), path)
        pq: list[tuple[float, str, float, list[str]]] = []
        f_s = 0 + heuristic(s)
        heapq.heappush(pq, (f_s, s, 0, [s]))

        visited: set[str] = set()
        while pq:
            f_u, u, g_u, path = heapq.heappop(pq)
            print(f"Visiting {u} with g={g_u} (f={f_u})")
            if u == t:
                return NodePath(path=path, cost=g_u)
            visited.add(u)

            for edge in self.adjacency_list[u]:
                v = edge.target
                # if v in visited:
                #     continue
                g_v = g_u + edge.cost
                h_v = heuristic(v)
                f_v = g_v + h_v
                print(f"  Considering {v} with g={g_v}, h={h_v} and f={f_v}")
                heapq.heappush(pq, (f_v, v, g_v, path + [v]))

        # If destination not reachable
        return None


def sao_carlos():
    graph = Graph()
    edges = [
        # São Carlos
        ["ICMC", "EESC", 3],
        ["ICMC", "IFSC", 10],
        ["ICMC", "BANDECO", 6],
        ["EESC", "CAASO", 2],
        ["EESC", "IFSC", 9],
        ["CAASO", "IFSC", 8],
        ["CAASO", "BANDECO", 2],
        ["IFSC", "BANDECO", 10],
    ]
    graph.add_edges(edges)

    distances_from = {
        "BANDECO": {
            "ICMC": 4,
            "EESC": 3,
            "CAASO": 1,
            "IFSC": 8,
            "BANDECO": 0,
        }
    }

    test_cases = [
        # ["ICMC", "CAASO"],
        # ["ICMC", "IFSC"],
        ["ICMC", "BANDECO"],
        # ["EESC", "BANDECO"],
        # ["IFSC", "BANDECO"],
        # ["CAASO", "BANDECO"],
        # ["POLI", "IQ"],
        # ["IME", "FAU"],
        # ["ICMC", "IME"],
        # ["EESC", "POLI"],
    ]
    for source, target in test_cases:
        heuristic = (
            (lambda u: distances_from[target][u]) if target in distances_from else None
        )

        print(f"\nSearching path from {source} to {target}:")
        result = graph.get_shortest_path(source, target, heuristic=heuristic)
        if result:
            print(
                f"{source} to {target} has cost {result.cost}: {' -> '.join(result.path)}"
            )
        else:
            print(f"No path found from {source} to {target}")


def asia():
    graph = Graph()
    edges = [
        # From the Romania map (each tuple: [city1, city2, distance])
        ["Arad", "Zerind", 75],
        ["Arad", "Timisoara", 118],
        ["Arad", "Sibiu", 140],
        ["Zerind", "Oradea", 71],
        ["Oradea", "Sibiu", 151],
        ["Timisoara", "Lugoj", 111],
        ["Lugoj", "Mehadia", 70],
        ["Mehadia", "Drobeta", 75],
        ["Drobeta", "Craiova", 120],
        ["Craiova", "Rimnicu Vilcea", 146],
        ["Craiova", "Pitesti", 138],
        ["Sibiu", "Rimnicu Vilcea", 80],
        ["Sibiu", "Fagaras", 99],
        ["Rimnicu Vilcea", "Pitesti", 97],
        ["Fagaras", "Bucharest", 211],
        ["Pitesti", "Bucharest", 101],
        ["Giurgiu", "Bucharest", 90],
        ["Urziceni", "Bucharest", 85],
        ["Urziceni", "Vaslui", 142],
        ["Urziceni", "Hirsova", 98],
        ["Hirsova", "Eforie", 86],
        ["Vaslui", "Iasi", 92],
        ["Iasi", "Neamt", 87],
    ]
    graph.add_edges(edges, bidirectional=True)

    # Straight-line heuristic distances to Bucharest (from the table in the image)
    distances_from = {
        "Arad": 366,
        "Bucharest": 0,
        "Craiova": 160,
        "Drobeta": 242,
        "Eforie": 161,
        "Fagaras": 176,
        "Giurgiu": 77,
        "Hirsova": 151,
        "Iasi": 226,
        "Lugoj": 244,
        "Mehadia": 241,
        "Neamt": 234,
        "Oradea": 380,
        "Pitesti": 100,
        "Rimnicu Vilcea": 193,
        "Sibiu": 253,
        "Timisoara": 329,
        "Urziceni": 80,
        "Vaslui": 199,
        "Zerind": 374,
    }

    def heuristic(u: str) -> float:
        return distances_from.get(u, float("inf"))

    path = graph.get_shortest_path("Arad", "Bucharest", heuristic=heuristic)
    if path:
        print(f"Path found: {' -> '.join(path.path)} with cost {path.cost}")
    else:
        print("No path found")


if __name__ == "__main__":
    sao_carlos()
