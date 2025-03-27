import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import technology.tabula.*;
import technology.tabula.extractors.SpreadsheetExtractionAlgorithm;

import javax.swing.*;
import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class CSVParser {
    public static void main(String[] args) throws IOException {
        URL urlAnexo1 = new URL("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf");

        TelaProgresso telaProgresso = new TelaProgresso();
        telaProgresso.atualizarDados(30, "Buscando AnexoI.pdf ..."); // Atualiza progresso

        try (InputStream anexo1Stream = urlAnexo1.openStream();
             PDDocument document = PDDocument.load(anexo1Stream);
             PrintWriter out = new PrintWriter("AnexoI.csv")) {

            SpreadsheetExtractionAlgorithm sea = new SpreadsheetExtractionAlgorithm();
            PageIterator pi = new ObjectExtractor(document).extract();

            int blankCellsCounter = 0; // Contador para evitar 2 linhas em branco no documento AnexoI.pdf
            final int anexo1Collumns = 13;

            telaProgresso.atualizarDados(70, "Escrevendo arquivo AnexoI.csv ...");

            while (pi.hasNext()) {
                Page page = pi.next();
                List<Table> tables = sea.extract(page);

                for (Table table : tables) {
                    List<List<RectangularTextContainer>> rows = table.getRows();

                    for (List<RectangularTextContainer> cells : rows) {
                        for(int i = 0 ; i < cells.size(); i++) {

                            if(blankCellsCounter < 2) { // Evita 2 primeiras linhas em branco
                                ++blankCellsCounter;
                                continue;
                            }

                            String text = cells.get(i).getText().replace("\r", " ");

                            if(text.equals("")) text = " ";
                            else if(text.equals("OD")) text = "Seg. Odontológica";
                            else if(text.equals("AMB")) text = "Seg. Ambulatorial";

                            out.printf("\"%s\"%s", text, i != anexo1Collumns -1 ? "," : "\n");
                        }
                    }
                }
            }

            telaProgresso.atualizarDados(99, "Zipando AnexoI.csv ...");
            // Zippando
            FileOutputStream fout = new FileOutputStream("Teste_Isaac_Guedes.zip");
            ZipOutputStream zout = new ZipOutputStream(fout);

            ZipEntry ze = new ZipEntry("AnexoI.csv");
            zout.putNextEntry(ze);
            byte[] bytes = Files.readAllBytes(Paths.get("AnexoI.csv"));
            zout.write(bytes, 0, bytes.length);
            zout.closeEntry();

            zout.close();
            fout.close();

            telaProgresso.dispose();

            JOptionPane.showMessageDialog(null,
                    "Extração concluída com sucesso! Os arquivos \'AnexoI.csv\' e \'Teste_Isaac_Guedes.zip\' podem ser acessados na pasta atual",
                    "Sucesso!", JOptionPane.INFORMATION_MESSAGE);
        }

    }

}





