package Controller;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import org.bson.Document;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/read-transactions")
public class ReadTransactionServlet extends HttpServlet {

    private MongoClient mongoClient;
    private MongoDatabase database;
    private MongoCollection<Document> collection;

    @Override
    public void init() throws ServletException {
        mongoClient = MongoClients.create("mongodb+srv://ngotranxuanhoa09062004:hoa09062004@gamehub.hzcoa.mongodb.net/?retryWrites=true&w=majority&appName=GameHub");
        database = mongoClient.getDatabase("GameHub");
        collection = database.getCollection("Transaction");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Document> transactions = new ArrayList<>();
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // Input format
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); // Desired output format

        try (MongoCursor<Document> cursor = collection.find().iterator()) {
            while (cursor.hasNext()) {
                Document doc = cursor.next();

                // Check if formattedCreateDate already exists
                if (!doc.containsKey("formattedCreateDate")) {
                    // Parse and format the createDate
                    String createDateString = doc.getString("createDate");
                    String formattedDate = "";

                    try {
                        Date date = inputFormat.parse(createDateString);
                        formattedDate = outputFormat.format(date);
                    } catch (ParseException e) {
                        e.printStackTrace(); // Handle parsing exceptions
                    }

                    // Update the document with the new formatted date
                    collection.updateOne(
                            new Document("_id", doc.getObjectId("_id")), // Match the original document by ID
                            new Document("$set", new Document("formattedCreateDate", formattedDate))
                    );

                    // Update the document locally to add it to the list
                    doc.append("formattedCreateDate", formattedDate);
                }

                transactions.add(doc);
            }
        }

        // Set the transactions as an attribute to be accessed in JSP
        request.setAttribute("transactionList", transactions);

        // Forward the request to a JSP page to display the transactions
        request.getRequestDispatcher("chart/index-chart.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        mongoClient.close(); // Close the MongoDB client
    }
}
