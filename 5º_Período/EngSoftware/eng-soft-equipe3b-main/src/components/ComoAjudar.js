          import React from 'react';
          import './components/ComoAjudar.css'; // Importar o arquivo CSS para os estilos

          const ComoAjudar = () => {
            return (
              <div className="comoajudar-screen">
                <header className="comoajudar-header">
                  <h1 className="entry-title">COMO AJUDAR</h1>
                </header>
                <main className="comoajudar-content">
                  <p>Você pode nos ajudar das seguintes maneiras:</p>

                  <ul className="comoajudar-list">
                    <li>Apadrinhe uma <a href="https://ongasa.wordpress.com/mutiroes-de-castracao/" target="_blank" rel="noopener noreferrer">castração</a> pelo valor de R$90,00 (em breve, informações bancárias).</li>
                    <li>Colabore com qualquer quantia a partir de R$5,00 (em breve, informações bancárias).</li>
                    <li>Participe dos nossos eventos. Organizamos <a href="https://ongasa.wordpress.com/feiras-de-adocao/" target="_blank" rel="noopener noreferrer">feiras de adoção</a> todo segundo sábado do mês, de 10h às 19h, na PETZ do Passeio São Carlos.</li>
                    <li>Divulgue nosso trabalho. Espalhe a ideia de que castrar é a única solução para o controle populacional de cães e gatos.</li>
                    <li>Pratique a posse responsável.</li>
                    <li>Siga-nos nas redes sociais.</li>
                  </ul>
                </main>
              </div>
            );
          };

          export default ComoAjudar;
