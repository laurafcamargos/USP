        #include <iostream>
        #include <vector>
        #include <string>
        #include <sstream>
        #include <cstring>
        using namespace std;

const int MAX_PROCESSORS = 10;  // Número máximo de processadores (0-9)
const int MAX_TASKS = 26;      // Número máximo de tarefas (A-Z)

bool findMatch(int task, vector<int> adj[], vector<bool>& visited, vector<int>& match) {
    for (int processor : adj[task]) {
        if (!visited[processor]) {
            visited[processor] = true;
            if (match[processor] == -1 || findMatch(match[processor], adj, visited, match)) {
                match[processor] = task;
                return true;
            }
        }
    }
    return false;
}

bool canAllocateTasks(const vector<string>& jobs) {
    vector<int> adj[MAX_TASKS];  //lista de adj
    int taskDemand[MAX_TASKS] = {0}; 
    for (const string& job : jobs) {
        char task = job[0];               //letra da tarefa
        int taskIndex = task - 'A';       //indice da tarefa no grafo
        int numUsers = job[1] - '0';      //numero de usuarios
        size_t spacePos = job.find(' ');  //posição do espaço em branco
        string processors = job.substr(spacePos + 1, job.find(';') - spacePos - 1); //lista de processadores

        taskDemand[taskIndex] = numUsers; //registrar a demanda da tarefa
        for (char p : processors) {
            adj[taskIndex].push_back(p - '0');  //adiciona o processador como vizinho
        }
    }

    vector<int> match(MAX_PROCESSORS, -1);  // Processador -> Tarefa alocada
    for (int task = 0; task < MAX_TASKS; ++task) {
        while (taskDemand[task] > 0) {
            vector<bool> visited(MAX_PROCESSORS, false);  //rastreamento de processadores visitados
            if (!findMatch(task, adj, visited, match)) {
                return false;  
            }
            taskDemand[task]--;  //reduzir a demanda para este emparelhamento
        }
    }

    return true;  //todas as tarefas foram alocadas
}

int main() {
    string input;
    vector<string> jobs;
    vector<string> results;

    string line;
    while (getline(cin, line)) {
        if (line.empty()) {
            if (!jobs.empty()) {
                if (canAllocateTasks(jobs)) {
                    results.push_back("YES");
                } else {
                    results.push_back("NO");
                }
                jobs.clear(); 
            }
        } else {
            jobs.push_back(line);
        }
    }

    if (!jobs.empty()) {
        if (canAllocateTasks(jobs)) {
            results.push_back("YES");
        } else {
            results.push_back("NO");
        }
    }

    for (const string& result : results) {
        cout << result << endl;
    }

    return 0;
}
