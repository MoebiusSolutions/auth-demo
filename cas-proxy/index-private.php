<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Example Private Content</title>
  </head>
  <body>
    <div class="container">
      <h1>Example Private Content</h1>
      <p><big>This page is restricted by CAS authentication.</big></p>
      <p>Attributes Returned by CAS:</p>
      <?php
        echo "<pre>";
        // Show user ID
        if (array_key_exists('REMOTE_USER', $_SERVER)) {
            echo "REMOTE_USER = " . $_SERVER['REMOTE_USER'] . "<br>";
        }
        // Show CAS headers
        $headers = getallheaders();
        foreach ($headers as $key => $value) {
            if (strpos($key, 'CAS_') === 0) {
                echo substr($key, 4) . " = " . $value . "<br>";
            }
        }
        echo "</pre>";
      ?>
    </div>
  </body>
</html>
