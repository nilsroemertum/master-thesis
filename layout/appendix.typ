#heading(level: 1, numbering: (level, ..nums) => [Appendix A], outlined: true)[Cloud-based PACS API Specification] <CloudInterfaceSpecification>

#heading(level: 2, numbering: (level, ..nums) => [A.1], outlined: false)[Uploading Pathology Images and Supplements to Google Cloud Storage]

#heading(level: 3, numbering: (level, ..nums) => [A.1.1], outlined: false)[Overview]

The system provides two distinct upload mechanisms for medical imaging data: direct supplement file uploads to Google Cloud Storage (GCS) and pathology image uploads that undergo conversion to DICOM format before being stored in both GCS and imported into the DICOM store. The DICOM store is managed by Dicoogle PACS, which serves as the backend storage system for the Google Cloud Healthcare API. This section specifies the API endpoints and workflows for these upload processes.

#heading(level: 3, numbering: (level, ..nums) => [A.1.2], outlined: false)[Supplement File Upload]

Supplement files (PDF, JPG, PNG, TXT) are uploaded directly to GCS without format conversion. These files serve as supplementary documentation alongside DICOM studies.

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.1], outlined: false)[API Endpoint]

*Endpoint*: `POST /api/files/supplements/upload`

*Content-Type*: `multipart/form-data`

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.2], outlined: false)[Request Parameters]

The request must include the following form fields:

- `file`: The file to be uploaded (required)
  - *Allowed types*: `application/pdf`, `image/jpeg`, `image/jpg`, `image/png`, `text/plain`
  - *Allowed extensions*: `.pdf`, `.jpg`, `.jpeg`, `.png`, `.txt`
  - *Maximum size*: 30 GB

- `caseId`: Case identifier for organizing uploaded files (required)

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.3], outlined: false)[Request Headers]

- `Authorization`: Bearer token for authentication
- `Content-Type`: `multipart/form-data; boundary=<boundary>`

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.4], outlined: false)[Storage Location]

Files are stored in GCS with the following path structure:

```
gs://{bucket_name}/supplements/{caseId}/{original_filename}
```

Where:
- `{bucket_name}`: Configured GCS bucket (e.g., `synlab-dicom-temporary-storage`)
- `{caseId}`: Provided case identifier
- `{original_filename}`: Original filename of the uploaded file

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.5], outlined: false)[Response]

*Status Code*: `201 Created`

*Response Body* (JSON):

```json
{
  "id": "string",
  "filename": "string",
  "filesize": number,
  "contentType": "string",
  "uploadedAt": "ISO 8601 timestamp",
  "gcsPath": "string",
  "publicUrl": "string"
}
```

*Response Fields*:
- `id`: Unique identifier for the supplement record
- `filename`: Original filename
- `filesize`: File size in bytes
- `contentType`: MIME type of the file
- `uploadedAt`: ISO 8601 timestamp of upload completion
- `gcsPath`: Path to the file in GCS
- `publicUrl`: Publicly accessible URL to the file

#heading(level: 4, numbering: (level, ..nums) => [A.1.2.6], outlined: false)[Error Responses]

- `400 Bad Request`: Invalid file type, missing file, or missing caseId
- `401 Unauthorized`: Invalid or missing authentication token
- `500 Internal Server Error`: Upload or storage failure

#heading(level: 3, numbering: (level, ..nums) => [A.1.3], outlined: false)[Pathology Image Upload and Conversion]

Pathology images in proprietary formats (`.isyntax`, `.i2syntax`) are uploaded and asynchronously converted to DICOM format. The conversion process generates multiple DICOM files that are stored in GCS and subsequently imported into a DICOM store via the Google Cloud Healthcare API.

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.1], outlined: false)[API Endpoint]

*Endpoint*: `POST /api/files/pathology/upload`

*Content-Type*: `multipart/form-data`

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.2], outlined: false)[Request Parameters]

- `file`: Pathology image file (required)
  - *Allowed extensions*: `.isyntax`, `.i2syntax`
  - *Maximum size*: 30 GB

- `caseId`: Case identifier for organizing converted DICOM files (required)

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.3], outlined: false)[Asynchronous Processing Workflow]

The upload initiates an asynchronous conversion job that proceeds through the following stages:

1. *Pending*: Job created and file prepared for conversion
2. *Converting*: Python-based conversion process using wsidicomizer transforms the proprietary format to DICOM
3. *Uploading*: Generated DICOM files are uploaded to GCS
4. *Importing to DICOM Store*: DICOM files are imported to Google Cloud Healthcare API DICOM store
5. *Completed*: All processing stages completed successfully
6. *Failed*: Error occurred during any stage

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.4], outlined: false)[Storage Location]

Converted DICOM files are stored in GCS with the following path structure:

```
gs://{bucket_name}/pathology/{caseId}/{original_filename_without_ext}/{dicom_filename}.dcm
```

Where:
- `{bucket_name}`: Configured GCS bucket
- `{caseId}`: Provided case identifier
- `{original_filename_without_ext}`: Original filename without the `.isyntax` or `.i2syntax` extension
- `{dicom_filename}`: Generated DICOM filename (typically numeric, e.g., `1.dcm`, `2.dcm`)

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.5], outlined: false)[Response]

*Status Code*: `202 Accepted`

*Response Body* (JSON):

```json
{
  "pathologyId": "string",
  "message": "string"
}
```

*Response Fields*:
- `pathologyId`: Database record identifier for the pathology upload
- `message`: Human-readable status message

#heading(level: 4, numbering: (level, ..nums) => [A.1.3.6], outlined: false)[DICOM Store Import]

Upon successful upload to GCS, DICOM files are automatically imported into the configured DICOM store. The DICOM store is managed by Dicoogle PACS, which provides the underlying storage infrastructure for the Google Cloud Healthcare API. The import operation uses a GCS URI pattern to identify all DICOM files in the case folder:

```
gs://{bucket_name}/pathology/{caseId}/{original_filename_without_ext}/*.dcm
```

The import is performed via the Healthcare API's import endpoint, which processes all matching files asynchronously and stores them in the Dicoogle PACS backend.

#heading(level: 2, numbering: (level, ..nums) => [A.2], outlined: false)[DICOMweb API Specification for Google Cloud Healthcare]

#heading(level: 3, numbering: (level, ..nums) => [A.2.1], outlined: false)[DICOM Hierarchy and Data Organization]

DICOM (Digital Imaging and Communications in Medicine) organizes medical imaging data in a hierarchical structure:

- *Study*: A collection of one or more series that represents a single examination or procedure. Each study has a unique Study Instance UID.
- *Series*: A set of images acquired during the same imaging sequence. Each series has a unique Series Instance UID and belongs to a single study.
- *Instance*: An individual DICOM image or object. Each instance has a unique SOP Instance UID and belongs to a single series.
- *Frame*: For multi-frame DICOM objects (such as whole slide images), a frame represents a single image within the instance, such as a tile in an image pyramid.

In the context of this system:
- Each uploaded pathology image is represented as a single *series* within a DICOM study.
- To simplify data organization and management, all pathology images are grouped into a single, static study with a fixed Study Instance UID.
- The conversion process from proprietary formats (`.isyntax`, `.i2syntax`) to DICOM generates multiple instances and frames per series, representing the different levels and tiles of the image pyramid structure used for whole slide imaging.

This hierarchical organization enables efficient querying at different levels: studies can be retrieved to obtain all pathology images, specific series can be retrieved to access individual images, and individual instances or frames can be retrieved for detailed viewing or processing.

#heading(level: 3, numbering: (level, ..nums) => [A.2.2], outlined: false)[Overview]

DICOMweb is a RESTful API standard (defined in DICOM Part 18) that enables web-based access to DICOM data. The Google Cloud Healthcare API implements DICOMweb services for querying and retrieving DICOM objects, utilizing Dicoogle PACS as the underlying storage and retrieval backend. Dicoogle PACS provides a robust, open-source PACS server that handles DICOM data storage and serves as the foundation for DICOMweb retrieval operations. This section specifies the DICOMweb endpoints for interacting with pathology imaging data stored in Google Cloud.

The DICOMweb services implemented include:
- *QIDO-RS* (Query based on ID for DICOM Objects - RESTful Services): For searching and querying DICOM objects
- *WADO-RS* (Web Access to DICOM Objects - RESTful Services): For retrieving DICOM instances, frames, and rendered images

#heading(level: 3, numbering: (level, ..nums) => [A.2.3], outlined: false)[Base URL Structure]

All DICOMweb endpoints follow the following base URL pattern:

```
https://healthcare.googleapis.com/v1/projects/{project_id}/locations/{location}/datasets/{dataset_id}/dicomStores/{dicom_store_id}/dicomWeb
```

*Path Parameters*:
- `{project_id}`: Google Cloud project identifier (e.g., `synlab-pacs-workflow`)
- `{location}`: Geographic location of the dataset (e.g., `europe-west3`, `us-central1`)
- `{dataset_id}`: Healthcare dataset identifier (e.g., `synlab-healthcare-dataset`)
- `{dicom_store_id}`: DICOM store identifier (e.g., `synlab-dicom-data-store`)

*Example Base URL*:
```
https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb
```

#heading(level: 3, numbering: (level, ..nums) => [A.2.4], outlined: false)[Authentication]

All DICOMweb requests require OAuth 2.0 authentication using Bearer tokens. The authentication scope required is:

```
https://www.googleapis.com/auth/cloud-healthcare
```

*Request Header*:
```
Authorization: Bearer {access_token}
```

The access token can be obtained through:
- Google Cloud SDK: `gcloud auth print-access-token`
- OAuth 2.0 flow with Google identity providers
- Service account credentials

#heading(level: 3, numbering: (level, ..nums) => [A.2.5], outlined: false)[QIDO-RS: Search for All Studies]

#heading(level: 4, numbering: (level, ..nums) => [A.2.5.1], outlined: false)[Endpoint Specification]

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies`

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `application/dicom+json` (required)

#heading(level: 4, numbering: (level, ..nums) => [A.2.5.2], outlined: false)[Query Parameters]

Optional query parameters for filtering studies based on DICOM attributes (because of anonymization the name is a fixed string 'Anonymized' for every study):

- `PatientID`: Filter by Patient ID (e.g., `PatientID=12345`)
- `PatientName`: Filter by patient name (e.g., `PatientName=Doe^John`)
- `StudyDate`: Filter by study date (e.g., `StudyDate=20240101`)
- `StudyInstanceUID`: Filter by Study Instance UID (e.g., `StudyInstanceUID=1.2.840.113619.2.176.2025`)
- `Modality`: Filter by imaging modality (e.g., `Modality=SM` for microscopy)
- `StudyDescription`: Filter by study description

Multiple parameters can be combined using `&` separator.

#heading(level: 4, numbering: (level, ..nums) => [A.2.5.3], outlined: false)[Response]

*Status Code*: `200 OK`

*Content-Type*: `application/dicom+json`

*Response Body*: JSON array containing DICOM study metadata objects. Each object contains DICOM tags in JSON format with group/element identifiers.

*Example Response*:
```json
[
  {
    "00080050": {
      "vr": "SH",
      "Value": ["12345"]
    },
    "00080020": {
      "vr": "DA",
      "Value": ["20240101"]
    },
    "0020000D": {
      "vr": "UI",
      "Value": ["1.2.840.113619.2.176.2025.12345"]
    },
    "00081030": {
      "vr": "LO",
      "Value": ["Pathology Study"]
    }
  }
]
```

#heading(level: 4, numbering: (level, ..nums) => [A.2.5.4], outlined: false)[Example Request]

```bash
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Accept: application/dicom+json" \
  "https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb/studies"
```

#heading(level: 3, numbering: (level, ..nums) => [A.2.6], outlined: false)[QIDO-RS: Retrieve Specific Study]

#heading(level: 4, numbering: (level, ..nums) => [A.2.6.1], outlined: false)[Endpoint Specification]

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}`

*Path Parameters*:
- `{study_uid}`: Study Instance UID (e.g., `1.2.840.113619.2.176.2025.12345`)

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `application/dicom+json` (for metadata) or `multipart/related; type="application/dicom"` (for instances)

#heading(level: 4, numbering: (level, ..nums) => [A.2.6.2], outlined: false)[Response Formats]

*Metadata Response* (`Accept: application/dicom+json`):
- *Status Code*: `200 OK`
- *Content-Type*: `application/dicom+json`
- *Body*: JSON object containing study metadata with DICOM tags

*Instance Response* (`Accept: multipart/related; type="application/dicom"`):
- *Status Code*: `200 OK`
- *Content-Type*: `multipart/related; type="application/dicom"; boundary=<boundary>`
- *Body*: Multipart message containing DICOM instance files in binary format

#heading(level: 4, numbering: (level, ..nums) => [A.2.6.3], outlined: false)[Example Request - Metadata]

```bash
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Accept: application/dicom+json" \
  "https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb/studies/1.2.840.113619.2.176.2025.12345"
```

#heading(level: 4, numbering: (level, ..nums) => [A.2.6.4], outlined: false)[Example Request - Instances]

```bash
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Accept: multipart/related; type=\"application/dicom\"" \
  "https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb/studies/1.2.840.113619.2.176.2025.12345" \
  --output study.dcm
```

#heading(level: 3, numbering: (level, ..nums) => [A.2.7], outlined: false)[WADO-RS: Retrieve Series Metadata]

#heading(level: 4, numbering: (level, ..nums) => [A.2.7.1], outlined: false)[Endpoint Specification]

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}/series`

*Path Parameters*:
- `{study_uid}`: Study Instance UID

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `application/dicom+json` (required)

#heading(level: 4, numbering: (level, ..nums) => [A.2.7.2], outlined: false)[Response]

*Status Code*: `200 OK`

*Content-Type*: `application/dicom+json`

*Response Body*: JSON array containing series metadata objects for all series within the specified study.

#heading(level: 3, numbering: (level, ..nums) => [A.2.8], outlined: false)[WADO-RS: Retrieve Instance Metadata]

#heading(level: 4, numbering: (level, ..nums) => [A.2.8.1], outlined: false)[Endpoint Specification]

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}/series/{series_uid}/instances`

*Path Parameters*:
- `{study_uid}`: Study Instance UID
- `{series_uid}`: Series Instance UID

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `application/dicom+json` (required)

#heading(level: 4, numbering: (level, ..nums) => [A.2.7.2], outlined: false)[Response]

*Status Code*: `200 OK`

*Content-Type*: `application/dicom+json`

*Response Body*: JSON array containing instance metadata objects for all instances within the specified series.

#heading(level: 3, numbering: (level, ..nums) => [A.2.9], outlined: false)[WADO-RS: Retrieve Specific Instance]

#heading(level: 4, numbering: (level, ..nums) => [A.2.9.1], outlined: false)[Endpoint Specification]

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}/series/{series_uid}/instances/{instance_uid}`

*Path Parameters*:
- `{study_uid}`: Study Instance UID
- `{series_uid}`: Series Instance UID
- `{instance_uid}`: SOP Instance UID

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `application/dicom` (for binary DICOM file) or `application/dicom+json` (for JSON metadata)

#heading(level: 4, numbering: (level, ..nums) => [A.2.9.2], outlined: false)[Response]

*Binary Response* (`Accept: application/dicom`):
- *Status Code*: `200 OK`
- *Content-Type*: `application/dicom`
- *Body*: Binary DICOM file

*JSON Response* (`Accept: application/dicom+json`):
- *Status Code*: `200 OK`
- *Content-Type*: `application/dicom+json`
- *Body*: JSON object with DICOM tags

#heading(level: 3, numbering: (level, ..nums) => [A.2.10], outlined: false)[WADO-RS: Dynamic Tiling and Image Pyramid for Whole Slide Imaging]

#heading(level: 4, numbering: (level, ..nums) => [A.2.10.1], outlined: false)[Overview]

Whole Slide Imaging (WSI) pathology images are stored using DICOM Supplement 145 (Whole Slide Microscopy Image), which defines a pyramid structure with multiple resolution levels. Each level contains tiles that can be retrieved individually, enabling efficient panning and zooming in viewers without loading the entire high-resolution image.

The image pyramid consists of:
- *Level 0*: Highest resolution (full image at native resolution)
- *Level 1..N*: Progressively lower resolutions (downsampled versions)
- *Tiles*: Sub-regions of each pyramid level, typically 256×256 or 512×512 pixels

#heading(level: 4, numbering: (level, ..nums) => [A.2.10.2], outlined: false)[Retrieve Rendered Frame]

For displaying rendered images (converted to standard image formats), use the rendered endpoint:

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}/series/{series_uid}/instances/{instance_uid}/frames/{frame_number}/rendered`

*Path Parameters*:
- `{study_uid}`: Study Instance UID
- `{series_uid}`: Series Instance UID
- `{instance_uid}`: SOP Instance UID
- `{frame_number}`: Frame number (1-based index)

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `image/jpeg` or `image/png`

*Query Parameters* (optional):
- `quality`: JPEG quality (1-100, default: 90)
- `viewport`: Viewport dimensions in pixels, e.g., `viewport=512,512`

*Response*:
- *Status Code*: `200 OK`
- *Content-Type*: `image/jpeg` or `image/png`
- *Body*: Rendered image in the requested format

*Example Request*:
```bash
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Accept: image/jpeg" \
  "https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb/studies/{study_uid}/series/{series_uid}/instances/{instance_uid}/frames/1/rendered?quality=90&viewport=512,512" \
  --output frame.jpg
```

#heading(level: 4, numbering: (level, ..nums) => [A.2.10.3], outlined: false)[Retrieve Specific Frame (Binary)]

To retrieve raw frame data in DICOM format:

*HTTP Method*: `GET`

*Endpoint*: `{base_url}/studies/{study_uid}/series/{series_uid}/instances/{instance_uid}/frames/{frame_number}`

*Path Parameters*:
- `{study_uid}`: Study Instance UID
- `{series_uid}`: Series Instance UID
- `{instance_uid}`: SOP Instance UID
- `{frame_number}`: Frame number (1-based index, or comma-separated list for multiple frames)

*Request Headers*:
- `Authorization`: `Bearer {access_token}` (required)
- `Accept`: `multipart/related; type="application/octet-stream"` (for binary frames) or `application/octet-stream` (for single frame)

*Query Parameters* (for WSI tile retrieval):
- Note: DICOM Supplement 145 defines tile-based access. Dicoogle PACS, which serves as the backend for Google Cloud Healthcare API, implements standard DICOMweb frame retrieval. The frame numbers correspond to tiles in the image pyramid structure.

*Response*:
- *Status Code*: `200 OK`
- *Content-Type*: `multipart/related; type="application/octet-stream"` or `application/octet-stream`
- *Body*: Binary frame data

*Example Request*:
```bash
curl -X GET \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Accept: application/octet-stream" \
  "https://healthcare.googleapis.com/v1/projects/synlab-pacs-workflow/locations/europe-west3/datasets/synlab-healthcare-dataset/dicomStores/synlab-dicom-data-store/dicomWeb/studies/{study_uid}/series/{series_uid}/instances/{instance_uid}/frames/1" \
  --output frame.raw
```

#heading(level: 4, numbering: (level, ..nums) => [A.2.10.4], outlined: false)[Image Pyramid Representation]

In DICOM WSI, the image pyramid is represented as multiple frames within a single instance or across multiple instances. The pyramid structure is encoded in DICOM tags:

- *Total Pixel Matrix Rows* (0048,0006): Total rows in the highest resolution level
- *Total Pixel Matrix Columns* (0048,0007): Total columns in the highest resolution level
- *NumberOfFrames* (0028,0008): Number of frames if stored as multi-frame
- *Per-frame Functional Groups Sequence* (5200,9230): Contains frame-specific metadata including:
  - *Frame Content Sequence*: Frame position and dimensions
  - *Plane Position Sequence*: Spatial location
  - *Whole Slide Microscopy Image Frame Type Sequence*: Frame type (e.g., "ORIGINAL", "DERIVED") and pyramid level

For dynamic tiling, viewers typically:
1. Query instance metadata to determine pyramid levels and tile dimensions
2. Calculate required tile coordinates based on viewport and zoom level
3. Retrieve specific frames corresponding to the required tiles
4. Cache tiles to minimize network requests during panning and zooming

#heading(level: 3, numbering: (level, ..nums) => [A.2.11], outlined: false)[Error Handling]

#heading(level: 4, numbering: (level, ..nums) => [A.2.11.1], outlined: false)[HTTP Status Codes]

- `200 OK`: Request succeeded
- `400 Bad Request`: Invalid request parameters or malformed DICOM data
- `401 Unauthorized`: Missing or invalid authentication token
- `403 Forbidden`: Insufficient permissions
- `404 Not Found`: Requested DICOM object not found
- `409 Conflict`: Duplicate instance or constraint violation
- `500 Internal Server Error`: Server-side error
- `503 Service Unavailable`: Service temporarily unavailable

#heading(level: 4, numbering: (level, ..nums) => [A.2.11.2], outlined: false)[Error Response Format]

Error responses include a JSON body with error details:

```json
{
  "error": {
    "code": number,
    "message": "string",
    "status": "string",
    "details": []
  }
}
```

#heading(level: 3, numbering: (level, ..nums) => [A.2.12], outlined: false)[References]

- DICOM Standard Part 18: Web Access to DICOM Persistent Objects (WADO). National Electrical Manufacturers Association, 2023.
- DICOM Supplement 145: Whole Slide Microscopy Image. National Electrical Manufacturers Association, 2022.
- Dicoogle PACS: Open-source PACS archive server. Available: https://www.dicoogle.com/
- Google Cloud Healthcare API Documentation: DICOMweb. Available: https://cloud.google.com/healthcare-api/docs/how-tos/dicomweb
- Google Cloud Healthcare API Reference. Available: https://cloud.google.com/healthcare-api/docs/reference/rest
- DICOMweb Client Libraries. Available: https://github.com/dcmjs-org/dicomweb-client
